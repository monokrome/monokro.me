import './audio_player.scss';


import {Component} from 'angular2/core';
import SoundCloud from 'services/soundcloud';


@Component({
  selector: '[data-audio-player]',
  template: require('./audio_player.html'),
})
export default class AudioPlayerComponent {
  constructor(soundcloud) {
    this.currentAudio = new Audio;
    this.bufferAudio = new Audio;

    document.body.appendChild(this.currentAudio);
    document.body.appendChild(this.bufferAudio);

    this.soundcloud = soundcloud;
    this.soundcloud.setClientId('c5c77f52385776590f11e7546f2c3c87');

    this.soundcloud.getTracks('monokrome')
      .subscribe(this.onTracksReceived.bind(this));
  }

  hasTrackPlaying() {
    return this.currentAudio.paused === false;
  }

  hasNoTrackPlaying() {
    return this.hasTrackPlaying() === false;
  }

  onTracksReceived(tracks) {
    this.tracks = tracks;
  }

  play(track) {
    this.currentTrack = track;
    this.currentAudio.src = this.soundcloud.getTrackUrl(track);
    this.currentAudio.play();
  }
}


AudioPlayerComponent.parameters = [SoundCloud];
