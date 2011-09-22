configuration = require './configuration'
controllers = require './controllers'
helpers = require './helpers'
express = require 'express'

server = express.createServer()

configuration.apply server
controllers.apply server
helpers.apply server

server.listen server.set 'listening-port'

