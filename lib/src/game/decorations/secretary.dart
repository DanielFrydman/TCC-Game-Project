import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class Secretary extends GameDecoration with ObjectCollision {
  bool _playerIsClose = false;

  Secretary(Vector2 position)
      : super(
          size: Vector2(0, 0),
          position: position,
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(60, 38), align: Vector2(-22, 0))
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
        radiusVision: 25);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [
              const TextSpan(
                  text:
                      'VOCÊ ESTÁ ATRASADO PARA A PALESTRA!! SUBA CORRENDO PARA O AUDITÓRIO!')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secretary.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [const TextSpan(text: 'AAAHHH!!')],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.idleDown.asWidget(),
            ))
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {});
    });
  }
}
