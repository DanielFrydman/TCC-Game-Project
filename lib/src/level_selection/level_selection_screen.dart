// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_template/src/level_selection/levels.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  static const _gap = SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: ResponsiveScreen(
          squarishMainArea: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Selecione o nível',
                    style: GoogleFonts.vt323(
                        textStyle: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w300,
                            shadows: <Shadow>[
                          Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 30)
                        ])),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final level in gameLevels)
                      ListTile(
                        enabled: playerProgress.highestLevelReached >=
                            level.number - 1,
                        onTap: () {
                          final audioController =
                              context.read<AudioController>();
                          audioController.playSfx(SfxType.buttonTap);

                          GoRouter.of(context)
                              .go('/play/session/${level.number}');
                        },
                        leading: Text(level.number.toString(),
                            style: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300))),
                        title: Text('Nível #${level.number}',
                            style: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600))),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: Text('Voltar',
                    style: GoogleFonts.vt323(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int getBackgroundForDayTime() {
  DateTime dateTime = DateTime.now();
  if (dateTime.hour >= 3 && dateTime.hour < 6) {
    return 0;
  } else if (dateTime.hour >= 6 && dateTime.hour < 18) {
    return 1;
  } else if (dateTime.hour >= 18 && dateTime.hour < 24) {
    return 2;
  } else {
    return 3;
  }
}

const backgrounds = [
  'assets/images/main_menu_backgrounds/morning_dawn.png',
  'assets/images/main_menu_backgrounds/morning.png',
  'assets/images/main_menu_backgrounds/night.png',
  'assets/images/main_menu_backgrounds/night_dawn.png'
];
