import React from 'react'
import DOM from 'react-dom/server'
import fs from 'fs'
import { Provider } from 'react-redux'
import { ServerStyleSheet } from 'styled-components'

import store from 'store'

import Application from '../components/application'

export default function render(request: Object) {
  const sheet = new ServerStyleSheet()

  const document = DOM.renderToString(sheet.collectStyles(
    <Provider store={store}>
      <Application />
    </Provider>
  ))

  return `
    <DOCTYPE html>

    <html>
      <head>
        <meta charset=UTF-8>
        <title>Welcome to React</title>
        ${sheet.getStyleTags()}
      </head>

      <body>
        <div id="root">${document}</div>
        <script src=/index.js></script>
      </body>
    </html>
  `
}
