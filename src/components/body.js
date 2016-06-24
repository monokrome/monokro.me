import './body.scss';

import {Component} from 'angular2/core';

import ArticleComponent from './article.js';
import AudioPlayerComponent from './audio_player.js';


@Component({
  selector: 'body',
  template: require('./body.html'),

  directives: [
    ArticleComponent,
    AudioPlayerComponent,
  ],

  providers: [],
})
export default class BodyComponent {}
