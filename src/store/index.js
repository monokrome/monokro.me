import { createStore } from 'redux'

// TODO: Look into better/conventional patterns for this
const ACTION_HANDLERS = {}

const reducer = (currentState: Object, action: Object) => {
  const handler = ACTION_HANDLERS[action.type]
  if (!handler) return currentState
  return handler(currentState, action) || currentState
}

export default createStore(reducer, {
  title: '❤',
})
