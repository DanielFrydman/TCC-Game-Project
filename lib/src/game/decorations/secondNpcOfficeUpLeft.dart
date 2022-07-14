import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';
import 'package:game_template/src/level_selection/levels.dart';

class SecondNpcOfficeUpLeft extends GameDecoration {
  bool _playerIsClose = false;
  final String herosName;

  SecondNpcOfficeUpLeft(Vector2 position, this.herosName)
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
        radiusVision: 25);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'Oie '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(
                  text:
                      ', tudo bom? Precisava que assinasse os documentos da sua entrada na empresa.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Oi, tudo sim e com você? Sem problemas, onde devo assinar?'),
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
                      'Tudo bem também! Ah, estamos fazendo a assinatura digitalmente, peço que faça pelo meu computador porque esse documento está atrasado e preciso enviar hoje.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Sem problemas, deixa eu ir ai.'),
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
              const TextSpan(text: '...................!!!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Nossa, um minuto, recebi um e-mail do nosso chefe solicitando a instalação de uma nova ferramenta de comunicação com urgência para nossa equipe começar a utilizar. A ferramenta está para download em anexo, deixa eu baixar aqui...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text: 'Espere! Vi aqui que o remetente desse e-mail é: '),
              const TextSpan(
                  text: 'bxfgrazz1020@anonymous.com',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.amber)),
              const TextSpan(
                  text:
                      '. É um e-mail desconhecido e, além disso, contem senso de urgência...'),
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
              const TextSpan(text: '. . . . . . . . .'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
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
          world: subLevelsWorldFour[0].world,
          map: subLevelsWorldFour[0].map,
          xPositionHero: subLevelsWorldFour[0].xHeroPosition,
          yPositionHero: subLevelsWorldFour[0].yHeroPosition,
          question: subLevelsWorldFour[0].question,
          rightAwnser: subLevelsWorldFour[0].rightAwnser,
          wrongAwnser: subLevelsWorldFour[0].wrongAwnser,
          awnser: subLevelsWorldFour[0].awnser,
          herosName: subLevelsWorldFour[0].herosName);
    }));
  }
}
