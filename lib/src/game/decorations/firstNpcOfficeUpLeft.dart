import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class FirstNpcOfficeUpLeft extends GameDecoration {
  bool _playerIsClose = false;
  final String herosName;

  FirstNpcOfficeUpLeft(Vector2 position, this.herosName)
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
        radiusVision: 10);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'Fala comigo '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(
                  text:
                      '!! Já percebeu que o chefe cobra muito a gente nas questões de segurança da informação né?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text: 'Eai, tudo bom? Percebi sim, o cara é fera. 🙅‍♂️'),
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
                      'Opa, tudo certo sim, obrigado por perguntar. Pois é, ele é muito bom.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Deixa eu te passar umas dicas... Você consegue identificar um e-mail falso?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Acredito que não, pode me explicar?'),
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
                      'Claro! Hoje, a principal causa de vulnerabilidade à segurança da informação é o fato humano. Sim, somos nós. Na maioria das vezes, os criminosos não utilizam de códigos maliciosos para atacar as empresa e sim a engenharia social contra os usuários mal preparados. E a principal ferramenta disso ainda é e-mail.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Engenharia social é uma técnica utilizada por criminosos virtuais para induzir os usuários desavisados a enviar dados que são confidenciais, a infectar seus computadores com malwares ou abrir links para sites que estejam infectados.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Existem algumas formas de identificar um e-mail falso. Para você ficar atento, vou citar algumas delas. Fique ligado se o remetente do e-mail é desconhecido ou estranho, se o e-mail tem um boleto, fatura ou nota fiscal anexada, se o e-mail pede seus dados bancários ou cadastrais...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Se o e-mail promete ganhos fáceis e rápidos, sem esforço, se as informações do e-mail são desencontradas ou possuem erros de português, se o e-mail apresenta senso de urgência, dentre outros...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Acho que agora você está craque para não cair em algum desses golpes!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Antes de te deixar partir, uma moça do RH pediu pra caso eu te encontrasse, falar pra você passar na mesa dela. Era pra assinar alguns documentos.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Bom dia e bom trabalho pra você.  😌'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpLeft.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Valeu mesmo! Pra você também!  🙂'),
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
        onFinish: () {},
      );
    });
  }
}
