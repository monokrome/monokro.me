import './body.scss';

import {NgZone, Component} from 'angular2/core';

import {HTTP_PROVIDERS} from 'angular2/http';

import ArticleComponent from './article.js';
import AudioPlayerComponent from './audio_player.js';

import Api from 'services/api';


@Component({
  selector: 'body',
  template: require('./body.html'),

  directives: [
    ArticleComponent,
  ],

  providers: [
    HTTP_PROVIDERS,
    Api,
  ],
})
export default class BodyComponent {}
