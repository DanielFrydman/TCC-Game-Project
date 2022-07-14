import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';
import 'package:game_template/src/level_selection/levels.dart';

class SecondNpcOfficeUpRight extends GameDecoration {
  bool _playerIsClose = false;
  final String herosName;

  SecondNpcOfficeUpRight(Vector2 position, this.herosName)
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
              const TextSpan(text: 'Ei, você aí.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Quem... eu?'),
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
              const TextSpan(text: 'É... você mesmo '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(
                  text:
                      '! Eu recebi um e-mail corporativo solicitando a atualização da minha senha para manter os meus acessos ao sistemas corporativos. Sabe de alguma coisa sobre isso?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Eu? Não to sabendo de nada, vamos ver juntos esse e-mail.'),
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
                      'Pelo que estou vendo, esse e-mail parece legítimo. Vamos clicar no link que abre a tela de atualização de senha...'),
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
                      'A tela de atualização parece legítima, tem toda aparência dos nossos sistemas corporativos e tem até o cadeado do lado da url... vou clicar!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Espera aí, a URL está como '),
              const TextSpan(
                  text:
                      'http://aprendendo-segurança-da-informação-com.io/atualiza-senha',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.amber)),
              const TextSpan(text: '...'),
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
              const TextSpan(text: 'Estou achando estranho...'),
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
              const TextSpan(text: 'Vamos clicar!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeUpRight.asWidget(),
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
          world: subLevelsWorldFive[0].world,
          map: subLevelsWorldFive[0].map,
          xPositionHero: subLevelsWorldFive[0].xHeroPosition,
          yPositionHero: subLevelsWorldFive[0].yHeroPosition,
          question: subLevelsWorldFive[0].question,
          rightAwnser: subLevelsWorldFive[0].rightAwnser,
          wrongAwnser: subLevelsWorldFive[0].wrongAwnser,
          awnser: subLevelsWorldFive[0].awnser,
          rightAwnserBonus: subLevelsWorldFive[0].rightAwnserBonus,
          bonusAwnser: subLevelsWorldFive[0].bonusAwnser,
          bonusOption: subLevelsWorldFive[0].bonusOption,
          herosName: subLevelsWorldFive[0].herosName);
    }));
  }
}
