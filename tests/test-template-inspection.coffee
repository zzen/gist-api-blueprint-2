{assert}  = require 'chai'
ast       = require '../apiary.ast.json'

{Blueprint} = require '../sdk'

describe 'SDK Templated resources', ->
  describe 'Non-templated path segment', ->
    describe 'When I send in non-templated path segment', ->
      $    = undefined
      body = JSON.stringify [{"url": "https://api.github.com/gists/xoxotest"}]
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
                  body: body
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

        it 'I get the specified response', ->
          assert.equal body, response.body


  describe 'Templated path segment', ->
    describe 'When I send in templated path segment', ->
      $    = undefined
      body = JSON.stringify [{"url": "https://api.github.com/gists/xoxotest"}]
      ast     = ast:
        metadata: FORMAT: '1A'
        name: 'Root collection'
        resourceGroups: [
          resources: [
            {
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
                    body: body
                  ]
                ]
              ]
            },
            {
              name: 'Gist'
              uriTemplate: '/gists/{id}'
              actions: [
                name: 'Retrieve single gist'
                method: 'GET'
                headers: {}
                examples: [
                  requests: []
                  responses: [
                    name: '200'
                    headers: 'content-type': value: 'application/json'
                    body: body
                  ]
                ]
              ]
            }
          ]
        ]

      before ->
        $ = new Blueprint(ast).sdk()


      it '#now I get it as resource attribute on SDK', ->
        assert.ok $.gists.gist

      describe 'and I can retrieve it', ->
        response = undefined
        before ->
          response = $.gists.gist.get()

        it 'I get proper content-type header', ->
          assert.equal 'application/json', response.headers['content-type']

        it 'I get the specified response', ->
          assert.equal body, response.body



