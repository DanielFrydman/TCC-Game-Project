// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final gameLevels = [
  GameLevel(
    number: 1,
    map: 'map/introduction/reception.json',
    world: 1,
    difficulty: 1,
    xHeroPosition: 24,
    yHeroPosition: 38,
    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  GameLevel(
    number: 2,
    map: 'map/introduction/reception.json',
    world: 1,
    difficulty: 1,
    xHeroPosition: 24,
    yHeroPosition: 38,
    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  )
];

class GameLevel {
  final int number;
  final int world;
  final String map;
  final int difficulty;
  final int xHeroPosition;
  final int yHeroPosition;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  const GameLevel({
    required this.number,
    required this.world,
    required this.map,
    required this.difficulty,
    required this.xHeroPosition,
    required this.yHeroPosition,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
