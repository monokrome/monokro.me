import {Component} from 'angular2/core';
import {BackdropDirective} from './backdrop';
import {World} from '../services/world';


@Component({
  selector: 'body',
  template: require('./body.html'),

  directives: [
    BackdropDirective,
  ],

  providers: [
    World,
  ]
})
export class BodyComponent {}
