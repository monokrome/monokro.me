import React from 'react';
import './index.css';


import NavigationComponent from '../navigation';
import ArticleComponent from '../article';


export default class AppComponent extends React.Component {
  render() {
    return (
      <section data-app>
        <header>
          <NavigationComponent />
        </header>

        <main>
          <ArticleComponent url='http://localhost:3100/articles?id=eq.1' />
          <ArticleComponent summary url='http://localhost:3100/articles?id=eq.2' />
        </main>

        <footer><NavigationComponent /></footer>
      </section>
    );
  }
}
