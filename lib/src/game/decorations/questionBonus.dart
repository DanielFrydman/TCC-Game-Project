import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class QuestionBonus extends GameDecoration with Sensor {
  bool _playerIsClose = false;
  final String question;
  final String bonusOption;

  QuestionBonus(Vector2 position, this.question, this.bonusOption)
      : super(position: position, size: Vector2(335, 78)) {
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
              TextSpan(
                  text: "a) (${getAwnserByOption("a) ")})",
                  style: TextStyle(color: Colors.amber)),
              TextSpan(text: '.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(text: 'Siga em '),
              TextSpan(
                  text: 'frente', style: TextStyle(color: Colors.tealAccent)),
              TextSpan(text: ' caso ache que a resposta certa seja a letra '),
              TextSpan(
                  text: "b) (${getAwnserByOption("b) ")})",
                  style: TextStyle(color: Colors.tealAccent)),
              TextSpan(text: '.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(text: 'Vá para a '),
              TextSpan(text: 'direita', style: TextStyle(color: Colors.red)),
              TextSpan(text: ' caso ache que a resposta certa seja a letra '),
              TextSpan(
                  text: "c) (${getAwnserByOption("c) ")})",
                  style: TextStyle(color: Colors.red)),
              TextSpan(text: '.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(text: 'Ao chegar próximo do computador, '),
              TextSpan(
                  text: 'pressione o botão de ação',
                  style: TextStyle(color: Colors.purpleAccent)),
              TextSpan(text: '.'),
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

  String getAwnserByOption(optionInString) {
    final question = this.question;
    final index = question.indexOf(optionInString);
    final option =
        question[index + 3] + question[index + 4] + question[index + 5];

    if (question[index + 6] == '.') {
      return option;
    }

    return bonusOption;
  }
}
