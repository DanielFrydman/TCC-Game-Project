import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/decorations/areYouSure.dart';
import 'package:game_template/src/game/decorations/awnserLeft.dart';
import 'package:game_template/src/game/decorations/awnserMiddle.dart';
import 'package:game_template/src/game/decorations/awnserRight.dart';
import 'package:game_template/src/game/decorations/candle.dart';
import 'package:game_template/src/game/decorations/firstNpcClothes.dart';
import 'package:game_template/src/game/decorations/firstNpcOfficeDown.dart';
import 'package:game_template/src/game/decorations/firstNpcOfficeUpLeft.dart';
import 'package:game_template/src/game/decorations/firstNpcOfficeUpRight.dart';
import 'package:game_template/src/game/decorations/question.dart';
import 'package:game_template/src/game/decorations/questionBonus.dart';
import 'package:game_template/src/game/decorations/receptionStairs.dart';
import 'package:game_template/src/game/decorations/secondNpcClothes.dart';
import 'package:game_template/src/game/decorations/secondNpcOfficeDown.dart';
import 'package:game_template/src/game/decorations/secondNpcOfficeUpLeft.dart';
import 'package:game_template/src/game/decorations/secondNpcOfficeUpRight.dart';
import 'package:game_template/src/game/decorations/secretary.dart';
import 'package:game_template/src/game/decorations/thirdNpcClothes.dart';
import 'package:game_template/src/game/decorations/thirdNpcOfficeDown.dart';
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
  final Direction direction;
  final int bonusAwnser;
  final String rightAwnserBonus;
  final String bonusOption;
  final String herosName;

  Game(
      {Key? key,
      required this.world,
      required this.map,
      required this.xPositionHero,
      required this.yPositionHero,
      this.question = "",
      this.rightAwnser = "",
      this.wrongAwnser = "",
      this.awnser = 0,
      this.direction = Direction.up,
      this.rightAwnserBonus = "",
      this.bonusAwnser = 0,
      this.bonusOption = "",
      this.herosName = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState(
      this.world,
      this.map,
      this.xPositionHero,
      this.yPositionHero,
      this.question,
      this.rightAwnser,
      this.wrongAwnser,
      this.awnser,
      this.direction,
      this.rightAwnserBonus,
      this.bonusAwnser,
      this.bonusOption,
      this.herosName);
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
  final Direction direction;
  final int bonusAwnser;
  final String rightAwnserBonus;
  final String bonusOption;
  final String herosName;

  _GameState(
      this.world,
      this.map,
      this.xPositionHero,
      this.yPositionHero,
      this.question,
      this.rightAwnser,
      this.wrongAwnser,
      this.awnser,
      this.direction,
      this.rightAwnserBonus,
      this.bonusAwnser,
      this.bonusOption,
      this.herosName);

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
        'totem': (properties) => Totem(properties.position, this.herosName),
        'receptionStairs': (properties) => ReceptionStairs(properties.position),
        'auditoriumNpc': (properties) =>
            AuditoriumNpc(properties.position, this.herosName),
        'candle': (properties) => Candle(properties.position),
        'areYouSure': (properties) => AreYouSure(properties.position),
        'question': (properties) =>
            Question(properties.position, this.question),
        'awnserLeft': (properties) => AwnserLeft(
            properties.position,
            this.world,
            this.rightAwnser,
            this.wrongAwnser,
            this.awnser,
            this.rightAwnserBonus,
            this.bonusAwnser,
            this.herosName,
            this.question),
        'awnserRight': (properties) => AwnserRight(
            properties.position,
            this.world,
            this.rightAwnser,
            this.wrongAwnser,
            this.awnser,
            this.rightAwnserBonus,
            this.bonusAwnser,
            this.herosName,
            this.question),
        'firstNpcClothes': (properties) =>
            FirstNpcClothes(properties.position, this.herosName),
        'secondNpcClothes': (properties) =>
            SecondNpcClothes(properties.position),
        'thirdNpcClothes': (properties) =>
            ThirdNpcClothes(properties.position, this.herosName),
        'firstNpcOfficeDown': (properties) =>
            FirstNpcOfficeDown(properties.position, this.herosName),
        'secondNpcOfficeDown': (properties) =>
            SecondNpcOfficeDown(properties.position, this.herosName),
        'thirdNpcOfficeDown': (properties) =>
            ThirdNpcOfficeDown(properties.position),
        'firstNpcOfficeUpLeft': (properties) =>
            FirstNpcOfficeUpLeft(properties.position, this.herosName),
        'secondNpcOfficeUpLeft': (properties) =>
            SecondNpcOfficeUpLeft(properties.position, this.herosName),
        'firstNpcOfficeUpRight': (properties) =>
            FirstNpcOfficeUpRight(properties.position),
        'secondNpcOfficeUpRight': (properties) =>
            SecondNpcOfficeUpRight(properties.position, this.herosName),
        'awnserMiddle': (properties) => AwnserMiddle(
            properties.position,
            this.world,
            this.rightAwnser,
            this.wrongAwnser,
            this.awnser,
            this.rightAwnserBonus,
            this.bonusAwnser,
            this.herosName,
            this.question),
        'questionBonus': (properties) =>
            QuestionBonus(properties.position, this.question, this.bonusOption),
      }),
      player: GameHero(
          Vector2(xPositionHero * titleSize, yPositionHero * titleSize),
          direction),
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
    if (map == 'map/questions.json' || map == 'map/questionsBonusRound.json') {
      return Colors.black.withOpacity(0.5);
    }

    return Colors.transparent;
  }
}
