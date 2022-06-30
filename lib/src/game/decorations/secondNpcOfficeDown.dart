import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class SecondNpcOfficeDown extends GameDecoration {
  bool _playerIsClose = false;

  SecondNpcOfficeDown(Vector2 position)
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
        radiusVision: 20);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 3, finish: () {
      TalkDialog.show(
        context,
        [
          Say(
            text: [
              const TextSpan(text: 'Opa, tudo bão? Hehehe 😁'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Tudo sim, devo me preocupar?'),
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
              const TextSpan(text: 'Claro que não, fique tranquilo.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Só queria te explicar sobre uma questão de segurança da informação muito imporante aqui na empresa... Hehehehe 😁'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Ah, entendi. Pode falar!'),
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
                      'Nossos computadores estão cheios de dados sensíveis. Não sei se entende o que são esses dados mas para te explicar, são informações confidenciais que devem ser protegidas contra o acesso não autorizado.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'O acesso aos dados sensíveis deve ser limitado por meio de práticas suficientes de segurança de dados e segurança de informações. Isso tudo visando impedir a divulgação não autorizada e violações de dados.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Além da nossa, muitas empresas tem que proteger dados confidenciais para requisitos éticos ou legais, privacidade pessoal, motivos regulatórios, segredos comerciais, dentre vários outros...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'O vazamento desses dados pode representar um risco social, risco de reputação, risco legal, risco de empregabilidade ou de segurança que pode se extender para nós mesmos e até nossos clientes.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Para finalizar, vou te dar alguns exemplos de dados sensíveis, são eles as informações pessoais, informações sobre saúde, prestação de serviços ou pagamentos, registros educacionais, informações de clientes, dados de titulares de cartões de cŕedito, dentre outros...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Acho que deu pra entender né? Vamos pra cima hein! Contamos com você!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Pode deixar!  ;D'),
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
                      'IH, quase que me esqueço... Tinha um rapaz precisando de uma ajuda sua em uma das mesas lá em cima. Acho que consegue encontrar ele... Se você por acaso se perder, o cabelo dele é verde! Hehehehe 😁'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.secondNpcOfficeDown.asWidget(),
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
