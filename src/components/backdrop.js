import {Directive, ElementRef} from 'angular2/core';
import {World} from '../services/world';


@Directive({selector: '[data-mk-backdrop]'})
export class BackdropDirective {
  constructor(el, world) {
    world.create(el.nativeElement.getContext('2d'));
  }
}


BackdropDirective.parameters = [
  ElementRef,
  World,
];
