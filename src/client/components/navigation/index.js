import React from 'react';
import './index.css';


export default class NavigationComponent extends React.Component {
  render() {
    return (
      <ul data-navigation>
        <li><a href='/'>Blog</a></li>
        <li><a href='https://github.com/monokrome/'>Code</a></li>
        <li><a href='https://soundcloud.com/monokrome/'>Music</a></li>
      </ul>
    );
  }
}
