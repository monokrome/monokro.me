import React, {Component} from 'react'
import PropTypes from 'prop-types'

import ExternalInclude from 'components/external_include'

export default class CodePen extends Component {
  static propTypes = {
    slug: PropTypes.string.isRequired,
    initialTab: PropTypes.oneOf(['html', 'css', 'js', 'result']),
    height: PropTypes.number,
  }

  static defaultProps = {
    height: 260,
    initialTab: 'result',
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
      <ExternalInclude src="https://codepen.io/eijs.js">
        <p
          className="codepen"
          data-height={height}
          data-slug-hash={slug}
          data-user={user}
          data-theme-id="0"
          data-default-tab={initialTab}
        />
      </ExternalInclude>
    )
  }
}
