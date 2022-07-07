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
    yHeroPosition: 26,
    question: '''Você aceitaria o pen drive para copiar a palestra?
    a) Sim.
    b) Não.''',
    rightAwnser:
        'Excelente resposta! A melhor decisão a se tomar é utilizar outro meio de compartilhamento de dados.   😀👏',
    wrongAwnser:
        'Você errou! A consequência da sua escolha seria um Malware(um tipo de vírus) implantado no seu computador que poderia te trazer diversos problemas.   🙁',
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
      yHeroPosition: 26,
      question:
          '''Você aceitaria tirar uma foto utilizando o crachá da sua empresa?
    a) Não.
    b) Sim.''',
      rightAwnser:
          'Excelente resposta! Não devemos postar fotos utilizando crachás com nossas informações.   😀👏',
      wrongAwnser:
          'Você errou! A consequência da sua escolha seria um criminoso se passando por você, um verdadeiro perigo!   🙁',
      awnser: 1)
];

final subLevelsWorldThree = [
  GameLevel(
      number: 3,
      map: 'map/questions.json',
      world: 3,
      difficulty: 10,
      xHeroPosition: 24,
      yHeroPosition: 26,
      question:
          '''Você deixaria seu colega informar uma série de informações sensíveis do computador para o fórum técnico?
    a) Sim.
    b) Não.''',
      rightAwnser:
          'Excelente resposta! Não devemos passar as informações e o que deveria ser feito seria buscar o help desk para resolver o problema. Help Desk seria o canal da empresa para ajudas técnicas.   😀👏',
      wrongAwnser:
          'Você errou! A consequência da sua escolha poderia ser alguém usando as informações para acessar remotamente o seu computador!   🙁',
      awnser: 2)
];

final subLevelsWorldFour = [
  GameLevel(
      number: 4,
      map: 'map/questions.json',
      world: 4,
      difficulty: 10,
      xHeroPosition: 24,
      yHeroPosition: 26,
      question:
          '''Você deixaria sua colega baixar a ferramenta que o suposto chefe solicitou por e-mail?
    a) Sim.
    b) Não.''',
      rightAwnser:
          'Excelente resposta! Você identificou que o e-mail se tratava de uma engenharia social e que era uma tentativa criminosa de instalar um malware(vírus) no computador.   😀👏',
      wrongAwnser:
          'Você errou! A consequência da sua escolha seria a instalação de um malware(vírus) no seu computador!   🙁',
      awnser: 2)
];

final subLevelsWorldFive = [
  GameLevel(
      number: 5,
      map: 'map/questionsBonusRound.json',
      world: 5,
      difficulty: 10,
      xHeroPosition: 24,
      yHeroPosition: 26,
      question:
          '''Você deixaria seu colega inserir os dados para atualização de senha?
      a) Sim.
      b) Não.
      c) Não e avisaria ao setor de segurança que a empresa está sob ataque direcionado.''',
      rightAwnser:
          'Excelente resposta! Você identificou se tratava de um site falso para tentar roubar os dados dos usuários.   😀👏',
      wrongAwnser:
          'Você errou! A consequência seriam suas credenciais sendo roubadas por um criminoso.   🙁',
      rightAwnserBonus:
          'Excepcional!!! Sem dúvidas, essa seria a melhor solução a se tomar. Além de identificar que se tratava de um site falso para tentar roubar os dados dos usuários, avisou a equipe que a empresa estava sob ataque.     😀👏',
      awnser: 2,
      bonusAwnser: 3,
      bonusOption:
          'Não e avisaria ao setor de segurança que a empresa está sob ataque direcionado')
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
  GameLevel(
      number: 3,
      map: 'map/world_3-4-5/world_3-4-5.json',
      world: 3,
      difficulty: 10,
      xHeroPosition: 16,
      yHeroPosition: 35,
      direction: Direction.right),
  GameLevel(
      number: 4,
      map: 'map/world_3-4-5/world_3-4-5.json',
      world: 4,
      difficulty: 10,
      xHeroPosition: 22,
      yHeroPosition: 22,
      direction: Direction.up),
  GameLevel(
      number: 5,
      map: 'map/world_3-4-5/world_3-4-5.json',
      world: 5,
      difficulty: 10,
      xHeroPosition: 26,
      yHeroPosition: 13,
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
  final int bonusAwnser;
  final String rightAwnserBonus;
  final String bonusOption;

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
    this.bonusAwnser = 0,
    this.rightAwnserBonus = "",
    this.bonusOption = "",
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
