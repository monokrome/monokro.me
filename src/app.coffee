configuration = require './configuration'
express = require 'express'

server = express.createServer()

configuration.apply server

server.listen server.set 'listening-port'

