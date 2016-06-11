import ng from 'angular2/core';
import {bootstrap} from 'angular2/platform/browser';


const BodyComponent = ng.Component({
  selector: 'body',
  template: `<h1>Hi!</h1>`,
}).Class({
  constructor: function () {
    console.log('Body applied.');
  }
});


bootstrap(BodyComponent);
