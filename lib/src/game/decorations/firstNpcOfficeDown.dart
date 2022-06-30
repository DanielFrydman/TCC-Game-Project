import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class FirstNpcOfficeDown extends GameDecoration {
  bool _playerIsClose = false;

  FirstNpcOfficeDown(Vector2 position)
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
        radiusVision: 35);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'Oie, bom dia!  😃'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Como está sendo seu segundo dia de trabalho? Muitos desafios?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Estou gostando e aprendendo muito!'),
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
                      'Que bom, muito feliz que podemos estar proporcionando esses momentos para você e tantas outras pessoas!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Bom... só vim te desejar um bom dia e te dizer que acho que o Chefe Astolfo quer falar com você.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Hmm, sabe sobre o que é?'),
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
                      'Acredito que seja sobre alguma informação que deve aprender por aqui.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
        ],
        onClose: () {
          gameRef.camera.moveToPlayerAnimated(zoom: 2);
        },
        onFinish: () {},
      );
    });
  }
}
