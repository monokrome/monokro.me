import {Http} from 'angular2/http';


export default class Api {
  constructor(http) {
    this.http = http;
  }

  getArticle(identifier) {
    return this.http.get(identifier)
      .map(res => res.json());
  }
}

Api.parameters = [Http];
