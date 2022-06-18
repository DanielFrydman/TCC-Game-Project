import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/player/hero.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class SecondNpcClothes extends GameDecoration {
  bool _playerIsClose = false;

  SecondNpcClothes(Vector2 position)
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
              const TextSpan(text: 'Você viu o que uma moça postou naquela rede social de fotos?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Eu não... o que foi?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second2NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Ela postou uma foto utilizando o crachá da empresa!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Ué... e qual é o problema disso?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second2NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Fazer isso é um grave incidente!!! Você não sabia?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Nossa, eu não fazia ideia. Poderia me explicar o motivo?'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second2NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Lógico! Não devemos fazer isso porque é um grande perigo. Nunca se sabe quem pode estar por trás da tela vendo suas informações. Cuidar da confidencialidade das informações é cada vez mais importante.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Você pode até ter orgulho da sua empresa, "vestir a camisa" e querer mostrar isso a todos mas as consequências podem ser gravíssimas. Ao fazer isso, pode se tornar visado e de alguma forma monitorado por criminosos virtuais.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Os criminosos podem replicar o seu crachá para tentar se passar por você e entrar na sua empresa. Além desse caso, suas informações podem ser roubadas e alguém pode tentar se passar por você fora da empresa.'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Nossa... eu não sabia que poderia causar isso tudo. Vou ficar mais ligado daqui pra frente, muito obrigado!'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second2NpcClothes.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              const TextSpan(text: 'Por nada!  ;)'),
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.second1NpcClothes.asWidget(),
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
