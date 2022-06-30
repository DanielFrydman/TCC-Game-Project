import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';
import 'package:game_template/src/level_selection/levels.dart';

class ThirdNpcOfficeDown extends GameDecoration {
  bool _playerIsClose = false;

  ThirdNpcOfficeDown(Vector2 position)
      : super(
          size: Vector2(0, 0),
          position: position,
        );

  @override
  void update(double dt) {
    seeComponentType<GameHero>(
        observed: (player) {
          if (!_playerIsClose) {
            _playerIsClose = true;
            _showDialog(this);
          }
        },
        notObserved: () {
          _playerIsClose = false;
        },
        radiusVision: 15);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'AAAAAAAAAAAAAAAAAAAAAAAAAAA 😖😖😖'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.thirdNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'O que foi???'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.idleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
          Say(
            text: [
              const TextSpan(
                  text: 'Estou com um problema e não sei como resolver!!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.thirdNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Me conte e vamos ver o que podemos fazer.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.idleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Apareceu esse problema técnico aqui no meu computador. Já tentei de tudo mas nada parece funcionar...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.thirdNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Mas eu tenho uma última alternativa, encontrei esse fórum técnico de dúvidas aqui na internet.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.thirdNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'A única coisa que eu preciso para me ajudarem a resolver é enviar essas informações sensíveis do computador que estou utilizando e pronto!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.thirdNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: '. . . . . . . . . . .'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.idleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
        ],
        onClose: () {
          gameRef.camera.moveToPlayerAnimated(zoom: 2);
        },
        onFinish: () {
          _goNextStage();
        },
      );
    });
  }

  void _goNextStage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Game(
          world: subLevelsWorldThree[0].world,
          map: subLevelsWorldThree[0].map,
          xPositionHero: subLevelsWorldThree[0].xHeroPosition,
          yPositionHero: subLevelsWorldThree[0].yHeroPosition,
          question: subLevelsWorldThree[0].question,
          rightAwnser: subLevelsWorldThree[0].rightAwnser,
          wrongAwnser: subLevelsWorldThree[0].wrongAwnser,
          awnser: subLevelsWorldThree[0].awnser);
    }));
  }
}
