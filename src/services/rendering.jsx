const fs = require('fs')

const DOM = require('react-dom/server')
const React = require('react')

const { Provider } = require('react-redux')
const { ServerStyleSheet } = require('styled-components')

import store from 'store'
import Application from '../components/application'

module.exports = function render(request: Object) {
  const sheet = new ServerStyleSheet()

  const document = sheet.collectStyles(
    <Provider store={store}>
      <Application />
    </Provider>
  )

  return `
    <DOCTYPE html>

    <html>
      <head>
        <meta charset=UTF-8>
        <title>Welcome to React</title>
        ${sheet.getStyleTags()}
      </head>

      <body>
        <div id="root">${DOM.renderToString(document)}</div>
        <script src=/index.js></script>
      </body>
    </html>
  `
}
