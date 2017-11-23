import React, {Component} from 'react'
import PropTypes from 'prop-types'

// Tracks whether or not we have injected the codepen script into this document
let externalScriptInstances = new Map()

export default class ExternalInclude extends Component {
  static propTypes = {
    src: PropTypes.string.isRequired,
    children: PropTypes.node.isRequired,
  }

  shouldComponentUpdate(nextProps) {
    return !externalScriptInstances.has(nextProps.src)
  }

  injectCodePenScript() {
    const {src} = this.props
    if (externalScriptInstances.has(src)) return

    const element = document.createElement('script')
    element.async = true
    element.src = src

    document.head.appendChild(element)
    externalScriptInstances.set(src, element)
  }

  render() {
    this.injectCodePenScript()
    return this.props.children
  }
}
