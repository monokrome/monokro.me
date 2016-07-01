import './article.scss';


import {Component, NgZone} from 'angular2/core';
import {Http} from 'angular2/http';


@Component({
  selector: 'article',
  template: require('./article.html'),
  inputs: ['url'],
  outputs: ['onUrlChanged'],
})
export default class ArticleComponent {
  constructor(zone, http) {
    this.zone = zone;
    this.http = http;

    this.zone.onStable.subscribe(this.update.bind(this));
  }

  onUpdateSuccess(data) { this.resource = data[0]; }

  onUpdateFailure(data) {
    this.resource = null;
    this.error = true;
  }

  update() {
    this.http.get(this.url)
      .map(res => res.text())
      .subscribe(
        this.onUpdateSuccess.bind(this),
        this.onUpdateFailure.bind(this)
      );
  }
}


ArticleComponent.parameters = [NgZone, Http];
