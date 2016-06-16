import {Directive} from 'angular2/core';
import {World} from '../services/world';


@Directive({selector: '[data-mk-backdrop]'})
export class BackdropDirective {
  constructor(world) {
    world.create();
  }
}


BackdropDirective.parameters = [World];
