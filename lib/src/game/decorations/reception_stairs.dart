import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';

class ReceptionStairs extends GameDecoration with Sensor {
  double dt = 0;
  bool _playerIsClose = false;

  ReceptionStairs(Vector2 position)
      : super(position: position, size: Vector2(45, 28)) {
    setupSensorArea(intervalCheck: 500);
  }

  @override
  void onContact(GameComponent component) {
    if (!_playerIsClose && component is Player) {
      _playerIsClose = true;
      _goNextStage();
    }
  }

  void _goNextStage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Game(
          map: 'map/introduction/auditorium.json',
          xPositionHero: 25,
          yPositionHero: 39);
    }));
  }
}
