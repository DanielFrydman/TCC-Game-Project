import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/decorations/reception_stairs.dart';
import 'package:game_template/src/game/decorations/secretary.dart';
import 'package:game_template/src/game/decorations/totem.dart';
import 'package:game_template/src/game/npcs/auditoriumNpc.dart';
import 'player/hero.dart';

class Game extends StatefulWidget {
  final String map;
  final int xPositionHero;
  final int yPositionHero;

  Game(
      {Key? key,
      required this.map,
      required this.xPositionHero,
      required this.yPositionHero})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _GameState(this.map, this.xPositionHero, this.yPositionHero);
}

class _GameState extends State<Game> {
  final double titleSize = 16;
  final String map;
  final int xPositionHero;
  final int yPositionHero;

  _GameState(this.map, this.xPositionHero, this.yPositionHero);

  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      joystick: Joystick(
          keyboardConfig: KeyboardConfig(
              keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
          directional: JoystickDirectional(color: Colors.cyan),
          actions: [
            JoystickAction(
                actionId: 1,
                color: Colors.cyan,
                margin: const EdgeInsets.all(75))
          ]),
      map: TiledWorldMap(this.map, objectsBuilder: {
        'secretary': (properties) => Secretary(properties.position),
        'totem': (properties) => Totem(properties.position),
        'receptionStairs': (properties) => ReceptionStairs(properties.position),
        'auditoriumNpc': (properties) => AuditoriumNpc(properties.position)
      }),
      player: GameHero(
          Vector2(xPositionHero * titleSize, yPositionHero * titleSize)),
      showCollisionArea: false,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: false,
        zoom: 2,
        sizeMovementWindow: Vector2(16 * 1, 16 * 1),
      ),
    );
  }
}
