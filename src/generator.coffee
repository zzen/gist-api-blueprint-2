#!/Users/jakub/.nvm/v0.8.15/bin/coffee

request = require 'request'
util = require 'util'


buffer = []
blueprint = null

process.stdin.resume();
process.stdin.setEncoding('utf8');

readStdIn = (cb) ->
  process.stdin.on 'data', (chunk) ->
    buffer.push chunk
  process.stdin.on 'end', ->
    blueprint = (Buffer.concat buffer).toString()
    cb null, blueprint

readStdIn (err, blueprint) ->
  request.post 'http://private-595e-jakubtest.apiary.io/blueprint/ast', json: blueprintCode: blueprint, (err, res, body) ->
    console.log JSON.stringify body, null, 2