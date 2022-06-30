import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class AreYouSure extends GameDecoration with Sensor {
  bool _playerIsClose = false;

  AreYouSure(Vector2 position)
      : super(position: position, size: Vector2(80, 100)) {
    setupSensorArea(intervalCheck: 500);
  }

  @override
  void onContact(GameComponent component) {
    seeComponentType<Player>(observed: (player) {
      if (!_playerIsClose) {
        _playerIsClose = true;
        _showDialog(this);
      }
    }, notObserved: () {
      _playerIsClose = false;
    });
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [const TextSpan(text: 'Você tem certeza da sua resposta?!')],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {});
    });
  }
}
