import './index.html'

import React from 'react'
import ReactDOM from 'react-dom'

import { Provider } from 'react-redux'

import store from 'store'
import Application from 'components/application'

ReactDOM.render(
  <Provider store={store}><Application /></Provider>,
  document.getElementById('root')
)

if (module.hot) module.hot.accept()
