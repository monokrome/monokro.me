import './index.html'

import React from 'react'
import ReactDOM from 'react-dom'

import { createStore } from 'redux'
import { Provider } from 'react-redux'

import reducer from 'reducers'
import Application from 'components/application'

const store = createStore(reducer, { title: '❤' })

ReactDOM.render(
  <Provider store={store}><Application /></Provider>,
  document.getElementById('root')
)

if (module.hot) module.hot.accept()
