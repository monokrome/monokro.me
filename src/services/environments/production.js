const express = require('express')
const render = require('services/rendering')

const STATIC_PATH = process.env.STATIC_PATH || 'dist'

const ReactRenderingService = require('./index')

function renderToResponse(request: Object, response: Object) {
  response.writeHead(200, {'Content-Type': 'text/html'})
  response.end(render(request))
}

class ReactProductionRenderingService extends ReactRenderingService {
  createServer() {
    const service = express()
    service.use(express.static(STATIC_PATH, {index: false}))
    service.get('/', renderToResponse)
    this.setService(service)
  }
}

module.exports = ReactProductionRenderingService
