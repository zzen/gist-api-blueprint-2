{assert}  = require 'chai'
ast       = require '../apiary.ast.json'

{Blueprint} = require '../sdk'

describe 'SDK Templated resources', ->
  describe 'Non-templated path segment', ->
    describe 'When I send in non-templated path segment', ->
      $ = undefined
      ast     = ast:
        metadata: FORMAT: '1A'
        name: 'Root collection'
        resourceGroups: [
          resources: [
            name: 'Gists'
            uriTemplate: '/gists'
            actions: [
              name: 'List Gists'
              method: 'GET'
              headers: {}
              examples: [
                requests: []
                responses: [
                  name: '200'
                  headers: 'content-type': value: 'application/json'
                  body: JSON.stringify [{"url": "https://api.github.com/gists/xoxotest"}]
                ]
              ]
            ]
          ]
        ]

      before ->
        $ = new Blueprint(ast).sdk()


      it 'I get it as collection attribute on SDK', ->
        assert.ok $.gists

      describe 'and I can retrieve it', ->
        response = undefined
        before ->
          response = $.gists.get()

        it 'I get proper content-type header', ->
          assert.equal 'application/json', response.headers['content-type']


