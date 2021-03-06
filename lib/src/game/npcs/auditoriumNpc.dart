import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';
import 'package:game_template/src/level_selection/levels.dart';

bool _playerIsClose = false;

class AuditoriumNpc extends SimpleNpc with ObjectCollision {
  final String herosName;

  AuditoriumNpc(Vector2 position, this.herosName)
      : super(
          position: position, //required
          size: Vector2(16, 32), //required
          speed: 50,
          initDirection: Direction.down,
          animation: SimpleDirectionAnimation(
            idleLeft: GameSpriteSheet.auditoriumNpcIdleLeft,
            idleRight: GameSpriteSheet.auditoriumNpcIdleRight, //required
            runLeft: GameSpriteSheet.auditoriumNpcRunLeft,
            runRight: GameSpriteSheet.auditoriumNpcRunRight, //required
            idleUp: GameSpriteSheet.auditoriumNpcIdleUp,
            idleDown: GameSpriteSheet.auditoriumNpcIdleDown,
            runUp: GameSpriteSheet.auditoriumNpcRunUp,
            runDown: GameSpriteSheet.auditoriumNpcRunDown,
          ),
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(10, 8), align: Vector2(3, 24))
    ]));
  }

  @override
  void update(double dt) {
    seePlayer(
        observed: (player) {
          if (!_playerIsClose) {
            _playerIsClose = true;
            _showDialog(player);
          }
        },
        notObserved: () {
          _playerIsClose = false;
        },
        radiusVision: 80);
    super.update(dt);
  }

  void _showDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 2.2, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [
              const TextSpan(
                  text:
                      'Pelo visto temos uma pessoa atrasada no primeiro dia... cof cof, '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(text: ', cof cof...'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [const TextSpan(text: '. . . . . .')],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.idleDown.asWidget(),
            )),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Pois bem... Dando in??cio a minha palestra sobre como e porque se deve reduzir o uso de pen drives por empresas, pergunto a voc??s, como se manter a seguran??a e a rapidez nos canais de transmiss??o de arquivos reduzindo o uso do pen drive?')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Bom, existem diversos pontos negativos para uso desses dispositivos port??teis. Citando algum deles, dispositivo pass??vel de perda/roubo, usado muito como instrumento de ataques cibern??ticos, f??cil roubo de informa????es confidenciais de empresas, dentre outros mas principalmente fonte de virus.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              const TextSpan(
                  text:
                      'N??o entraremos em detalhes sobre os tipos de v??rus nessa palestra mas para voc??s ficarem sabendo, um v??rus ?? um software(um programa) malicioso que ?? desenvolvido por programadores inescrupulosos. Esses programas infectam o sistema do usu??rio realizam a????es sem que dono do sistema saiba.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Voltando ao assunto, existem pesquisas que comprovam que 30% dos v??rus encontrados em m??quinas s??o provenientes de pen drives... Muitas empresas resolveram banir o uso de dispositivos port??teis como solu????o de seguran??a.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Pretendo mostrar a voc??s uns dados que trouxe e pelas imagens no projetor voc??s podem ver...')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Senhor... N??s estamos com problemas com a conex??o do projetor...')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumTechGuy.asWidget(),
            )),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Se me permitirem, eu posso copiar a palestra por pen drive!')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumPenDriveGirl.asWidget(),
            )),
        Say(
            text: [const TextSpan(text: '. . . . . . . . . . . .')],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {
        _goNextStage();
      });
    });
  }

  void _goNextStage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Game(
          world: subLevelsWorldOne[1].world,
          map: subLevelsWorldOne[1].map,
          xPositionHero: subLevelsWorldOne[1].xHeroPosition,
          yPositionHero: subLevelsWorldOne[1].yHeroPosition,
          question: subLevelsWorldOne[1].question,
          rightAwnser: subLevelsWorldOne[1].rightAwnser,
          wrongAwnser: subLevelsWorldOne[1].wrongAwnser,
          awnser: subLevelsWorldOne[1].awnser,
          herosName: subLevelsWorldOne[1].herosName);
    }));
  }
}
