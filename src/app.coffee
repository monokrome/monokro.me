configuration = require './configuration'
helpers = require './helpers'
express = require 'express'

server = express.createServer()

configuration.apply server
helpers.apply server

server.listen server.set 'listening-port'
