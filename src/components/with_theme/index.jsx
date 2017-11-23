import PropTypes from 'prop-types'
import React, {Component} from 'react'
import {ThemeProvider} from 'styled-components'
import {connect} from 'react-redux'
import themes from 'design/themes'

class WithTheme extends Component {
  static propTypes = {
    theme: PropTypes.string.isRequired,
    children: PropTypes.node.isRequired,
  }

  render() {
    const theme = themes[this.props.theme] || themes.default
    return <ThemeProvider theme={theme}>{this.props.children}</ThemeProvider>
  }
}

function mapStateToProps(state, ownProps) {
  return {theme: ownProps.theme || state.theme.current}
}

export default connect(mapStateToProps)(WithTheme)
