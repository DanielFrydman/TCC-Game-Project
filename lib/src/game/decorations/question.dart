import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class Question extends GameDecoration with Sensor {
  bool _playerIsClose = false;
  final String question;

  Question(Vector2 position, this.question)
      : super(position: position, size: Vector2(180, 78)) {
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
            text: [
              const TextSpan(
                  text:
                      'Sobre o que você acabou de ver, responda sábiamente a pergunta...')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [TextSpan(text: this.question)],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(text: 'Vá para a '),
              TextSpan(text: 'esquerda', style: TextStyle(color: Colors.amber)),
              TextSpan(text: ' caso ache que a resposta certa seja a letra '),
              TextSpan(text: 'a)', style: TextStyle(color: Colors.amber)),
              TextSpan(text: ' e para a '),
              TextSpan(text: 'direita', style: TextStyle(color: Colors.red)),
              TextSpan(text: ' caso ache que seja '),
              TextSpan(text: 'b)', style: TextStyle(color: Colors.red)),
              TextSpan(text: '. Ao chegar próximo ao computador, pressione o botão de ação.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [TextSpan(text: 'Suas escolhas terão consequências...')],
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
