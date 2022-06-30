import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class FirstNpcOfficeUpRight extends GameDecoration {
  bool _playerIsClose = false;

  FirstNpcOfficeUpRight(Vector2 position)
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
              const TextSpan(
                  text:
                      'Olha quem está aqui, a mais nova revelação da empresa.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Que nada, pare com isso...'),
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
                      'Acredita que um dia desses eu cai em um golpe de um site falso?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text: 'Sério? Acho que se fosse comigo, eu também cairia...'),
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
                      'Pois é, a única coisa boa disso tudo é que eu fui atras de informação para aprender e nunca mais acontecer.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text: 'Pô, me conta! Gostaria muito de saber também.'),
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
                      'É pra já! Primeiro temos que saber que muitos dos sites fraudulentos copiam empresas famosas. Às vezes pode parecer que está visitando um site muito famoso e ser uma imitação quase idêntica dos sites originais, o que fazem os usuários cairem em alguns golpes, tipo o que aconteceu comigo.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Então... o que fazer em uma hora dessas? Prestar atenção nos detalhes é a coisa mais importante. Alguns elementos nas páginas indicam se o endereço é confiável ou se estamos na presença de um site falso.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Falando sobre o que pode indicar a falta de veracidade nos sites, preste atenção no link. Observe o domínio da página, os sites falsos costumam mostrar um endereço parecido mas com alguma mudança na URL que geralmente passa sem ser percebido. Um exemplo seria, ao invés de entrar no google.com, estaria entrando no g00gle.com, algo assim só que mais sutil.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Criminosos tendem a utilizar domínios menos conhecidos também. Ao invés de utilizar ".com", ".com.br", ou ".org", utilizam terminações esquisitas como ".biz", ".net", dentre outros...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Outra coisa é que qualquer site da rede começa com "http://" ou "https://" e esses são os protocolos para permitir a conexão entre o usuário e a página de destino. Quando a barra de endereço mostra algum ícone de cadeado fechado ao lado dessas letras que falei, significa que a URL conseguiu um certificado de segurança.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Em outras palavras, os dados desse site são protegidos por criptografia, o que garante uma navegação mais confiável. Mas lembre-se de que o cadeado sozinho não significa proteção total, alguns criminosos conseguem criptografar até mesmo as informações de sites falsos.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Confira também os selos de segurança, além do cadeado, você pode procurar outros certificados de segurança na própria página suspeita. Busque por indicadores de segurança como elementos no site que demonstrem a credibilidade da loja que está acessando, por exemplo.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(
                  text:
                      'Acho que uma última coisa que pode fazer é pesquisar no google porque os mecanismos de busca, graças a um algoritmo, ranqueia as páginas com base na reputação, o que signifca que sites falsos tem dificuldade de aparecer em destaque, mas não é impossível de acontecer, então preste atenção!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Acho que é isso...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Nossa, que aula! Aprendi muito!!'),
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
              const TextSpan(text: '😉'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.firstNpcOfficeUpRight.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: '😄'),
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
