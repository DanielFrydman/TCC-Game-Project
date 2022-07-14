// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_template/src/game/game.dart';
import 'package:provider/provider.dart';
import 'package:game_template/src/level_selection/levels.dart';

import '../ads/ads_controller.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../level_selection/levels.dart';

class PlaySessionScreen extends StatefulWidget {
  final GameLevel level;

  const PlaySessionScreen(
    this.level, {
    Key? key,
  }) : super(key: key);

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState(this.level);
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  final GameLevel level;
  _PlaySessionScreenState(this.level);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Game(
            world: level.world,
            map: level.map,
            xPositionHero: level.xHeroPosition,
            yPositionHero: level.yHeroPosition,
            question: level.question,
            rightAwnser: level.rightAwnser,
            wrongAwnser: level.wrongAwnser,
            awnser: level.awnser,
            direction: level.direction,
            bonusOption: level.bonusOption,
            herosName: level.herosName));
  }

  @override
  void initState() {
    super.initState();
    // Preload ad for the win screen.
    final adsRemoved =
        context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    if (!adsRemoved) {
      final adsController = context.read<AdsController?>();
      adsController?.preloadAd();
    }
  }
}
