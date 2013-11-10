bp         = require './apiary.ast.json'
utp        = require 'uritemplate'
inflection = require 'inflection'
inflection.isSingular = (str) -> inflection.singularize(str) is str
inflection.isPlural   = (str) -> inflection.pluralize(str)   is str

VERBOSE = !!process.env.VERBOSE
###
Assumptions:
- no multiple resources with same name
- when singular and plural name present, those represent a collection and it's item
###

class Blueprint
  constructor: (@bp) ->
    @resources = [].concat.apply [], (resource.name for resource in group.resources for group in @bp.ast.resourceGroups)
    @collections = (resource for resource in @resources when inflection.isSingular(resource) and inflection.pluralize(resource) in @resources)
    console.log "resources: %j", @resources if VERBOSE
    console.log "collection: %j", @collections if VERBOSE

  sdk: ->
    obj = {}
    for group in @bp.ast.resourceGroups
      for resource in group.resources
        obj[resource.name.toLowerCase()] = new Resource(resource)
    return obj

class Resource
  constructor: (resource) ->
    for action in resource.actions
      do (action) =>
        @[action.method.toLowerCase()] = new Action resource, action

class Action
  constructor: (resource, action) ->
    response = action.examples[0].responses[0] if action.examples.length? and action.examples[0].responses.length
    return ->
      console.log "calling #{action.method} #{resource.uriTemplate}" if VERBOSE
      headers = {}
      console.error 'response', response
      headers[k] = v.value for k,v of response.headers
      return headers: headers, body: response.body

module.exports = {
  Blueprint
}
