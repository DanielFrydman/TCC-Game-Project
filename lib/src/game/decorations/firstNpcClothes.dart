import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class FirstNpcClothes extends GameDecoration {
  bool _playerIsClose = false;

  FirstNpcClothes(Vector2 position)
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
              const TextSpan(text: '...........!!!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Nem tinha te visto aí, me perdoe!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Foi você quem chegou atrasado na palestra, né? Tinha um rapaz te procurando...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Se eu não me engano, ele está lá atrás em algum provador!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Mas antes disso, explore os aredores, talvez encontre algo interessante para aprender...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcClothes.asWidget(),
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
