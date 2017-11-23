import React, {Component} from 'react'
import PropTypes from 'prop-types'

const CODEPEN_SCRIPT_URL = 'https://codepen.io/eijs.js'

// Tracks whether or not we have injected the codepen script into this document
let embedScriptInstance = null

export default class CodePen extends Component {
  static propTypes = {
    slug: PropTypes.string.isRequired,
    user: PropTypes.string.isRequired,
    initialTab: PropTypes.oneOf(['html', 'css', 'js', 'code']),
    height: PropTypes.number,
  }

  static defaultProps = {
    height: 320,
    initialTab: 'result',
  }

  constructor() {
    super()
    this.injectCodePenScript()
  }

  injectCodePenScript() {
    if (embedScriptInstance) document.head.removeChild(embedScriptInstance)
    const element = document.createElement('script')
    element.async = true
    element.src = CODEPEN_SCRIPT_URL
    document.head.appendChild(element)
    embedScriptInstance = element
  }

  getUserURL() {
    return `https://codepen.io/${this.props.user}`
  }

  getPenURL() {
    return `${this.getUserURL()}/pen/${this.props.slug}`
  }

  render() {
    const {slug, user, initialTab} = this.props
    const height = this.props.height

    return (
      <p
        className="codepen"
        data-height={height}
        data-slug-hash={slug}
        data-user={user}
        data-theme-id="0"
        data-default-tab={initialTab}
      />
    )
  }
}
