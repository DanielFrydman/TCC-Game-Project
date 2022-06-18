import 'package:bonfire/bonfire.dart';
// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
final subLevelsWorldOne = [
  GameLevel(
      number: 1,
      map: 'map/introduction/auditorium.json',
      world: 1,
      difficulty: 10,
      xHeroPosition: 25,
      yHeroPosition: 39),
  GameLevel(
    number: 1,
    map: 'map/questions.json',
    world: 1,
    difficulty: 10,
    xHeroPosition: 24,
    yHeroPosition: 39,
    question: '''Você aceitaria o pen drive para copiar a palestra?
    a) Sim.
    b) Não.''',
    rightAwnser:
        'Excelente resposta! A melhor decisão a se tomar é utilizar outro meio de compartilhamento de dados.   :)',
    wrongAwnser:
        'Você errou! A consequência da sua escolha seria um Malware(um tipo de vírus) implantado no seu computador que poderia te trazer diversos problemas.   :(',
    awnser: 2,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  )
];

final subLevelsWorldTwo = [
  GameLevel(
    number: 2,
    map: 'map/questions.json',
    world: 2,
    difficulty: 10,
    xHeroPosition: 24,
    yHeroPosition: 39,
    question: '''Você aceitaria tirar uma foto utilizando o crachá da sua empresa?
    a) Não.
    b) Sim.''',
    rightAwnser:
        'Excelente resposta! Não devemos postar fotos utilizando crachás com nossas informações.   :)',
    wrongAwnser:
        'Você errou! A consequência da sua escolha seria u criminoso se passando por você, um verdadeiro perigo!   :(',
    awnser: 1,
  )
];


final gameLevels = [
  GameLevel(
      number: 1,
      map: 'map/introduction/reception.json',
      world: 1,
      difficulty: 10,
      xHeroPosition: 24,
      yHeroPosition: 38),
  GameLevel(
      number: 2,
      map: 'map/world_2/clothing_store.json',
      world: 2,
      difficulty: 10,
      xHeroPosition: 15,
      yHeroPosition: 37,
      direction: Direction.right),
];

class GameLevel {
  final int number;
  final int world;
  final String map;
  final int difficulty;
  final int xHeroPosition;
  final int yHeroPosition;
  final String question;
  final String rightAwnser;
  final String wrongAwnser;
  final int awnser;
  final Direction direction;

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
    this.question = "",
    this.rightAwnser = "",
    this.wrongAwnser = "",
    this.awnser = 0,
    this.direction = Direction.up,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
