# Scales

### [scales-app.com](https://www.scales-app.com)

<p align="left">
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-v2.7.2-green.svg" alt="ruby version"/>
  </a>
  <a href="http://rubyonrails.org/">
    <img src="https://img.shields.io/badge/Rails-v6.0.3-brightgreen.svg" alt="rails version"/>
  </a>
</p>

### Overview

Scales is a musical writing tool that can quickly generate scales, chords, and chord progressions. Scales and progressions can be listened to in the browser and the progression midi files downloaded for use in a DAW of choice.

### Dependencies

[Tone.js](https://tonejs.github.io)
<br/>
[Midilib](https://github.com/jimm/midilib)
<br/>
[Milligram CSS](https://milligram.io)

### Installation

Install Dependencies
```
bundle install

yarn install
```

Setup Database (not currently used, but must exist)
```
bundle exec rails db:setup
```

Start Server
```
bundle exec rails s
```

Navigate to [localhost:3000](localhost:3000)
