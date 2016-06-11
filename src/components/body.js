import ng from 'angular2/core';


export const BodyComponent = ng.Component({
  selector: 'body',
  template: `<h1>Hi!</h1>`,
}).Class({
  constructor: function () {
    console.log('Body applied.');
  }
});
