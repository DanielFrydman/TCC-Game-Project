import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

bool _playerIsClose = false;

class AuditoriumNpc extends SimpleNpc with ObjectCollision {
  AuditoriumNpc(Vector2 position)
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
                      'Pelo visto temos uma pessoa atrasada no primeiro dia...')
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
              height: 150,
              width: 150,
              child: GameSpriteSheet.idleDown.asWidget(),
            )),
        Say(
            text: [
              const TextSpan(
                  text:
                      'Pois bem... Dando início a minha palestra sobre [----TEXTO PRONTO COM MATÉRIA----].')
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
                  text: 'Bom, pelas imagens no projetor vocês podem ver..')
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
                      'Senhor.. estamos com problemas com a conexão do projetor..')
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
                      'Se me permitirem, eu posso copiar a palestra por pen-drive!')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumPenDriveGirl.asWidget(),
            )),
        Say(
            text: [
              const TextSpan(
                  text:
                      'VOCÊ ESTÁ DOIDA?! Não prestou atenção no que acabei de explicar?')
            ],
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
