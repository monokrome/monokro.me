# Create and initialize a new Application after the DOM has fully loaded.

Application = require 'application'

jQuery ->
  application = new Application
  application.initialize()

