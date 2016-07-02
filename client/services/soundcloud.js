import {Http} from 'angular2/http';
import {sortBy} from 'lodash';


const kinds = {};


function getPrioritizedTracks(tracks) {
  return sortBy(tracks, 'playback_count', 'download_count');
}


function responseAsJson(response) {
  return response.json();
}


export default class SoundCloud {
  constructor(http) {
    this.http = http;
  }

  setClientId(clientId) {
    this.clientId = clientId;
  }

  getApiUrl(url) {
    return url + '?client_id=' + this.clientId;
  }

  getTrackUrl(track) {
    return this.getApiUrl(track.stream_url);
  }

  getTracks(userName) {
    const url = `https://api.soundcloud.com/users/${ userName }/tracks/`;
    return this.http.get(this.getApiUrl(url))
      .map(responseAsJson)
      .map(getPrioritizedTracks);
  }
}


SoundCloud.parameters = [Http];
