// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const Set<Song> songs = {
  // Filenames with whitespace break package:audioplayers on iOS
  // (as of February 2022), so we use no whitespace.
  Song('Zane_Little_Music-It_takes_a_hero.mp3', 'It takes a hero', artist: 'Zane Little Music'),
  Song('Zane_Little_Music-Moms_workout_cd.mp3', 'Moms workout cd', artist: 'Zane Little Music'),
  Song('Zane_Little_Music-Space_cadet_training_montage.mp3', 'Space cadet training montage', artist: 'Zane Little Music'),
  Song('Zane_Little_Music-Stumble_around.mp3', 'Stumble around', artist: 'Zane Little Music'),
  Song('Zane_Little_Music-The_world_is_ours.mp3', 'The world is ours', artist: 'Zane Little Music')
};

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
