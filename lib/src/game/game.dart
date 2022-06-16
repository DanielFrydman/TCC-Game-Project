import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/decorations/are_you_sure.dart';
import 'package:game_template/src/game/decorations/awnserLeft.dart';
import 'package:game_template/src/game/decorations/awnserRight.dart';
import 'package:game_template/src/game/decorations/candle.dart';
import 'package:game_template/src/game/decorations/question.dart';
import 'package:game_template/src/game/decorations/reception_stairs.dart';
import 'package:game_template/src/game/decorations/secretary.dart';
import 'package:game_template/src/game/decorations/totem.dart';
import 'package:game_template/src/game/npcs/auditoriumNpc.dart';
import 'player/hero.dart';

class Game extends StatefulWidget {
  final int world;
  final String map;
  final int xPositionHero;
  final int yPositionHero;
  final String question;
  final String rightAwnser;
  final String wrongAwnser;
  final int awnser;

  Game({
    Key? key,
    required this.world,
    required this.map,
    required this.xPositionHero,
    required this.yPositionHero,
    this.question = "",
    this.rightAwnser = "",
    this.wrongAwnser = "",
    this.awnser = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState(
      this.world,
      this.map,
      this.xPositionHero,
      this.yPositionHero,
      this.question,
      this.rightAwnser,
      this.wrongAwnser,
      this.awnser);
}

class _GameState extends State<Game> {
  final int world;
  final double titleSize = 16;
  final String map;
  final int xPositionHero;
  final int yPositionHero;
  final question;
  final rightAwnser;
  final wrongAwnser;
  final awnser;

  _GameState(this.world, this.map, this.xPositionHero, this.yPositionHero,
      this.question, this.rightAwnser, this.wrongAwnser, this.awnser);

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
                margin: const EdgeInsets.all(75)),
          ]),
      map: TiledWorldMap(this.map, objectsBuilder: {
        'secretary': (properties) => Secretary(properties.position),
        'totem': (properties) => Totem(properties.position),
        'receptionStairs': (properties) => ReceptionStairs(properties.position),
        'auditoriumNpc': (properties) => AuditoriumNpc(properties.position),
        'candle': (properties) => Candle(properties.position),
        'areYouSure': (properties) => AreYouSure(properties.position),
        'question': (properties) =>
            Question(properties.position, this.question),
        'awnserLeft': (properties) => AwnserLeft(properties.position,
            this.world, this.rightAwnser, this.wrongAwnser, this.awnser),
        'awnserRight': (properties) => AwnserRight(properties.position,
            this.world, this.rightAwnser, this.wrongAwnser, this.awnser)
      }),
      player: GameHero(
          Vector2(xPositionHero * titleSize, yPositionHero * titleSize)),
      showCollisionArea: false,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: false,
        zoom: 2,
        sizeMovementWindow: Vector2(16 * 1, 16 * 1),
      ),
      lightingColorGame: getLightning(this.map),
    );
  }

  Color getLightning(map) {
    if (map == 'map/questions.json') {
      return Colors.black.withOpacity(0.5);
    }

    return Colors.transparent;
  }
}
