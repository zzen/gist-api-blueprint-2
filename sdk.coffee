bp         = require './apiary.ast.json'
utp        = require 'uritemplate'
inflection = require 'inflection'
request    = require 'request'
inflection.isSingular = (str) -> inflection.singularize(str) is str
inflection.isPlural   = (str) -> inflection.pluralize(str)   is str

VERBOSE = 1
OFFLINE = 1
###
Assumptions:
- no multiple resources with same name
- when singular and plural name present, those represent a collection and it's item
###


class Blueprint
  constructor: (@bp) ->
    @host        = @bp.ast.metadata.HOST.value
    @groups      = @bp.ast.resourceGroups
    @resources   = [].concat.apply [], (resource for resource in group.resources for group in @groups)
    @collections = (resource for resource in @resources when inflection.isSingular(resource.name) and inflection.pluralize(resource.name) in @resources)

  sdk: ->
    obj = {}
    for group in @groups
      for resource in group.resources
        obj[resource.name.toLowerCase()] = new Resource(@, resource)
    return obj

class Resource
  constructor: (@bp, @resource) ->
    for action in @resource.actions
      do (action) =>
        switch action.method
          when "GET"    then @find   = new Action @, action
          when "DELETE" then @remove = new Action @, action
          when "POST"   then @update = new Action @, action
          when "PATCH"  then @update = new Action @, action

class Action
  constructor: (resource, action) ->
    url  = resource.bp.host+resource.resource.uriTemplate # FIXME: needs parameter substitution
    req  = action.examples?[0].request?[0]
    res  = action.examples?[0].responses?[0]
    for r in [req, res] when r
      r.headers = new -> @[k] = v.value for k,v of r.headers; @

    return (cb) ->
      console.log "calling #{action.method} #{url}" if VERBOSE
      if OFFLINE
        resp =
          status:  res?.name
          headers: res?.headers
          body:    res?.body
        cb null, resp, resp.body
      else
        args =
          method:  action.method
          url:     url
          body:    req?.body
          headers: req?.headers
        request args, cb

module.exports = {
  Blueprint
}
