import './article.scss';

import Api from 'services/api';

import {Component, NgZone} from 'angular2/core';
import {Http} from 'angular2/http';

@Component({
  selector: 'article',
  template: require('./article.html'),
  inputs: [
    'url',
  ],
})
export default class ArticleComponent {
  constructor(zone, api) {
    this.api = api;
    this.zone = zone;

    this.zone.onStable.subscribe(this.update.bind(this));
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

  update() {
    return this.api.getArticle(this.url).subscribe(
      this.onUpdateSuccess.bind(this),
      this.onUpdateFailure.bind(this)
    );
  }
}


ArticleComponent.parameters = [NgZone, Api];
