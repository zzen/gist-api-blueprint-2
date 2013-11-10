bp         = require './apiary.ast.json'
utp        = require 'uritemplate'
inflection = require 'inflection'
inflection.isSingular = (str) -> inflection.singularize(str) is str
inflection.isPlural   = (str) -> inflection.pluralize(str)   is str

VERBOSE = 1
###
Assumptions:
- no multiple resources with same name
- when singular and plural name present, those represent a collection and it's item
###

class Blueprint
  constructor: (@bp) ->
    @resources = [].concat.apply [], (resource.name for resource in group.resources for group in @bp.ast.resourceGroups)
    @collections = (resource for resource in @resources when inflection.isSingular(resource) and inflection.pluralize(resource) in @resources)
    console.log "resources: %j", @resources
    console.log "collection: %j", @collections

  sdk: ->
    obj = {}
    for group in @bp.ast.resourceGroups
      for resource in group.resources
        obj[resource.name.toLowerCase()] = new Resource(resource)
    return obj

class Resource
  constructor: (resource) ->
    actions = (action.method for action in resource.actions)
    for action in resource.actions
      do (action) =>
        switch action.method
          when "GET"    then @find   = new Action resource, action
          when "DELETE" then @remove = new Action resource, action
          when "POST"   then @update = new Action resource, action
          when "PATCH"  then @update = new Action resource, action

class Action
  constructor: (resource, action) ->
    response = action.examples[0].responses[0] if action.examples.length? and action.examples[0].responses.length
    return ->
      console.log "calling #{action.method} #{resource.uriTemplate}" if VERBOSE
      headers = {}
      headers[k] = v.value for k,v of response.headers
      return headers: headers, body: response.body

module.exports = {
  Blueprint
}
