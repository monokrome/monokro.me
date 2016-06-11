import {Component} from 'angular2/core';


@Component({
  selector: 'body',
  template: `<h1>Hi!</h1>`,
})
export class BodyComponent {
  constructor() {
    console.log('Body applied.');
  }
}
