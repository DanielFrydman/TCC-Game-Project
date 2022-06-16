import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class Totem extends GameDecoration with ObjectCollision {
  bool _playerIsClose = false;

  Totem(Vector2 position)
      : super(
          size: Vector2(0, 0),
          position: position,
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(15, 16.5), align: Vector2(0, 0))
    ]));
  }

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
        radiusVision: 30);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'Seja muito bem-vindo ao ´'),
              const TextSpan(
                  text: 'Aprendendo Segurança da Informação',
                  style: TextStyle(color: Colors.amber)),
              const TextSpan(text: '´!'),
            ],
            person: SizedBox(
              height: 250,
              width: 250,
              child: GameSpriteSheet.book.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
              text: [const TextSpan(text: 'Poxa, que legal!')],
              person: SizedBox(
                height: 100,
                width: 100,
                child: GameSpriteSheet.readingBook.asWidget(),
              )),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Ao longo do jogo, você poderá interagir com pessoas, ou objetos, '),
              const TextSpan(
                  text: 'se aproximando',
                  style: TextStyle(color: Colors.amber)),
              const TextSpan(text: '...')
            ],
            person: SizedBox(
              height: 250,
              width: 250,
              child: GameSpriteSheet.book.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Preste atenção nas instruções e nas matérias que forem passadas, elas vão te salvar por aqui!'),
            ],
            person: SizedBox(
              height: 250,
              width: 250,
              child: GameSpriteSheet.book.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
              text: [const TextSpan(text: 'Certo...')],
              person: SizedBox(
                height: 100,
                width: 100,
                child: GameSpriteSheet.readingBook.asWidget(),
              )),
          Say(
            text: [
              const TextSpan(text: 'Espero que se divirta! ;)'),
            ],
            person: SizedBox(
              height: 250,
              width: 250,
              child: GameSpriteSheet.book.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Ahhh... uma última coisa! Acho que a secretária quer falar com você.'),
            ],
            person: SizedBox(
              height: 250,
              width: 250,
              child: GameSpriteSheet.book.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
              text: [const TextSpan(text: '. . . . . . . ops . . . . . . .')],
              person: SizedBox(
                height: 100,
                width: 100,
                child: GameSpriteSheet.readingBook.asWidget(),
              ))
        ],
        onClose: () {
          gameRef.camera.moveToPlayerAnimated(zoom: 2);
        },
        onFinish: () {},
      );
    });
  }
}
