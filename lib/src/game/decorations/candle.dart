import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class Candle extends GameDecoration with Lighting {
  Candle(Vector2 position) : super(position: position, size: Vector2(10, 10)) {
    setupLighting(LightingConfig(radius: 16 * 1, color: Colors.transparent));
  }
}
