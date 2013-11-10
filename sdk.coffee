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
    @collections = []
    availableResources = []

    for g in @bp.ast.resourceGroups
      for r in g.resources
        availableResources.push r

    for resource in availableResources
      if resource.uriTemplate.split('/').length is 2
        @collections.push new Collection resource, @

    for collection in @collections
      candidates = []
      for resource in availableResources
        if collection.prefix is resource.uriTemplate.slice 0, collection.prefix.length
          candidates.push new Resource resource, @

      collection.parseResources candidates

  sdk: ->
    obj = {}
    for group in @bp.ast.resourceGroups
      for resource in group.resources
        obj[resource.name.toLowerCase()] = new Resource(resource)
    return obj

class Resource
  constructor: (resource, @bp) ->
    for action in resource.actions or []
      @[action.method.toLowerCase()] = new Action resource, action

    @name        = resource.name
    @uriTemplate = resource.uriTemplate


class Collection
  constructor: (collection, @bp) ->
    for action in collection.actions or []
      @[action.method.toLowerCase()] = new Action collection, action

    @name   = collection.name
    @prefix = collection.uriTemplate

  parseResources: (availableResources) ->
    resources = []
    for resource in availableResources
      if @prefix is resource.uriTemplate?.split 0, @prefix.length
        strippedTemplate = resource.uriTemplate.split 0, @prefix.length
        try
          parsedTemplate = utp.parse strippedTemplate
        catch err
          continue

        console.error 'parsed', parsedTemplate

        if parsedTemplate.expressions.length > 0 and parsedTemplate.expressions[0].templateText
          resources.push resource

    @resources = resources


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
  Collection
  Resource
}
