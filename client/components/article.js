import './article.scss';

import Api from 'services/api';

import {Component} from 'angular2/core';
import {Http} from 'angular2/http';

@Component({
  selector: 'article',
  template: require('./article.html'),
  inputs: [
    'url',
  ],
})
export default class ArticleComponent {
  constructor(api) {
    this.api = api;
  }

  onUpdateSuccess(resources) {
    const resource = resources[0];
    this.title = resource.title;
    this.body = resource.body;
  }

  onUpdateFailure(data) {
    this.resource = null;
    this.error = true;
  }

  set url(url) {
    var old = this._url;
    if (old === url) return;

    this._url = url;
    this.update();
  }

  get url() {
    return this._url;
  }

  update() {
    return this.api.getArticle(this.url).subscribe(
      this.onUpdateSuccess.bind(this),
      this.onUpdateFailure.bind(this)
    );
  }
}


ArticleComponent.parameters = [Api];
