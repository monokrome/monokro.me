import React, {Component} from 'react'
import PropTypes from 'prop-types'
import styled from 'styled-components'

class Article extends Component {
  static propTypes = {
    header: PropTypes.node,
    children: PropTypes.node,
    footer: PropTypes.node,
    className: PropTypes.string.isRequired,
  }

  render() {
    const {header, children, footer, className} = this.props

    return (
      <article className={className}>
        {header && (
          <header>
            <h3>{header}</h3>
          </header>
        )}

        {children && <section>{children}</section>}
        {footer && <footer>{footer}</footer>}
      </article>
    )
  }
}

export default styled(Article)`
  max-width: 30em;
  user-select: none;

  > header {
    padding-left: 1rem;
    background-color: ${props => props.theme.dark};

    > h3 {
      color: ${props => props.theme.light};
    }
  }

  > section {
    user-select: text;
  }
`
