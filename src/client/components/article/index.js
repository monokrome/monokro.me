import Q from 'q';
import React from 'react';
import moment from 'moment';
import request from 'browser-request';

import './index.css';


export default class ArticleComponent extends React.Component {
  constructor() {
    super();

    this.state = {
      article: {},
    };
  }

  onStateChange(event) {
    const response = event.target;
    if (response.readyState !== 4) return;
    this.setState(JSON.parse(response.responseText)[0]);
  }

  onResponse(result) {
    const response = result[1];
    if (!response.length) return;

    this.setState({
      article: response[0]
    });
  }

  fetch(url) {
    const options = {
      url: url,
      json: true,
    };

    Q.nfcall(request, options).done(this.onResponse.bind(this));
    this.lastFetchedUrl = url;
  }

  getFriendlyPublishedDate() {
    return moment(this.state.published_time).fromNow();
  }

  getClassName() {
    const classes = [];
    if (this.state.isSummary) classes.push('summary');
    return classes.join(' ');
  }

  getContent() {
    const hasSummary = this.state.isSummary && this.state.article.summary;
    if (hasSummary) return this.state.article.summary;
    return this.state.article.body;
  }

  handleArticleClicked() {
    this.setState({
      isSummary: false,
    });
  }

  componentWillMount() {
    this.fetch(this.props.url);

    this.setState({
      isSummary: this.props.summary || false,
    });
  }

  componentWillReceiveProps() {
    if (this.props.url !== this.lastFetchedUrl) this.fetch(this.props.url);
  }

  render() {
    const content = {__html: this.getContent()};

    return (
      <article className={this.getClassName()}>
        <header><h3>{this.state.article.title}</h3></header>

        <section
          onClick={this.handleArticleClicked.bind(this)}
          dangerouslySetInnerHTML={content}>
        </section>

        <footer>
          <h6>Published {this.getFriendlyPublishedDate()}</h6>
        </footer>
      </article>
    );
  }
}
