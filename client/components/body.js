import './body.scss';

import {NgZone, Component} from 'angular2/core';

import {HTTP_PROVIDERS} from 'angular2/http';

import ArticleComponent from './article.js';
import AudioPlayerComponent from './audio_player.js';

import Api from 'services/api';
import SoundCloud from 'services/soundcloud';


@Component({
  selector: 'body',
  template: require('./body.html'),

  directives: [
    ArticleComponent,
    AudioPlayerComponent,
  ],

  providers: [
    HTTP_PROVIDERS,

    Api,
    SoundCloud,
  ],
})
export default class BodyComponent {}
