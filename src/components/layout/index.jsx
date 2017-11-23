import React, {Component} from 'react'
import PropTypes from 'prop-types'
import styled from 'styled-components'

class Layout extends Component {
  static propTypes = {
    // Display mode for the children in this layout
    mode: PropTypes.oneOf(['flex', 'block', 'inline', 'inline-block']),

    // Direction for Flex layout
    direction: PropTypes.oneOf(['row', 'column']),

    children: PropTypes.node,
    className: PropTypes.string.isRequired,
  }

  static defaultProps = {
    mode: 'flex',
    direction: 'row',
  }

  render() {
    const {className, children} = this.props
    return <section className={className}>{children}</section>
  }
}

export default styled(Layout)`
  display: ${props => props.mode};

  ${props => {
    if (props.mode === 'flex') return `flex-direction: ${props.direction}`
  }};

  h3 {
    color: ${props => props.theme.darkest};
  }
`
