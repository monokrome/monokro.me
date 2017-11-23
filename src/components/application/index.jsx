import React, {Component} from 'react'
import PropTypes from 'prop-types'
import styled from 'styled-components'

import Article from 'components/article'
import CodePen from 'components/codepen'
import Layout from 'components/layout'
import WithTheme from 'components/with_theme'

class Application extends Component {
  static propTypes = {
    className: PropTypes.string.isRequired,
  }

  render() {
    return (
      <WithTheme>
        <Layout>
          <main>
            <Article
              className={this.props.className}
              header="Lorem ipsum dolor sit amet">
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam
                elementum rutrum lorem, et efficitur dolor. Nulla vel tempor
                turpis. Maecenas nunc libero, blandit sed ultrices at, auctor
                egestas ipsum. Duis semper ante sed quam scelerisque, at
                finibus erat dapibus. Praesent lacinia in dolor non pulvinar.
                Vestibulum vulputate, ligula eu placerat finibus, ante odio
                iaculis lectus, a commodo quam nulla non est. Nam sollicitudin
                vulputate placerat. Duis molestie tortor in quam vulputate,
                blandit scelerisque ex varius. Praesent sit amet elementum
                nulla, id sodales dui.
              </p>

              <CodePen slug="rVYOao" user="monokrome" />

              <p>
                Vestibulum vel enim neque. Quisque mollis commodo nulla id
                venenatis. Mauris accumsan pellentesque augue id tempor. Sed eu
                justo rhoncus, sagittis eros id, bibendum velit. Phasellus
                blandit velit enim, at imperdiet leo consectetur eu. Nam
                ultrices risus in turpis tristique, scelerisque accumsan ante
                tempor. Quisque rutrum sem ac massa lacinia, at gravida velit
                commodo. Nulla dolor est, sollicitudin et nisl vel, luctus
                tincidunt eros. Vivamus blandit sapien et massa dapibus, nec
                lobortis quam consectetur. Morbi ultricies pulvinar augue sit
                amet accumsan. Aliquam viverra semper ligula at posuere.
              </p>
            </Article>
          </main>
        </Layout>
      </WithTheme>
    )
  }
}

export default styled(Application)`
  margin: 0 auto;
`
