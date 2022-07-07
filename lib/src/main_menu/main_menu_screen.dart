// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gamesServicesController = context.watch<GamesServicesController?>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Transform.rotate(
                angle: -0.1,
                child: Text(
                  'Aprendendo Segurança\nda Informação!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        fontSize: 60,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        shadows: <Shadow>[
                          Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 30)
                        ]),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      audioController.playSfx(SfxType.buttonTap);
                      GoRouter.of(context).go('/menu/play');
                    },
                    child: Text(
                      'Jogar',
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFff0000),
                        textStyle: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: 30,
                              height: 1,
                              fontWeight: FontWeight.w500),
                        ))),
                if (gamesServicesController != null) ...[
                  _hideUntilReady(
                      ready: gamesServicesController.signedIn,
                      child: ElevatedButton(
                          onPressed: () =>
                              gamesServicesController.showAchievements(),
                          child: Text('Conquistas'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFff0000),
                              textStyle: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    height: 1,
                                    fontWeight: FontWeight.w500),
                              )))),
                  _hideUntilReady(
                      ready: gamesServicesController.signedIn,
                      child: ElevatedButton(
                          onPressed: () =>
                              gamesServicesController.showLeaderboard(),
                          child: Text('Placar de Líderes'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFff0000),
                              textStyle: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    height: 1,
                                    fontWeight: FontWeight.w500),
                              )))),
                ],
                ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/menu/settings'),
                    child: Text('Configurações'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFff0000),
                        textStyle: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: 30,
                              height: 1,
                              fontWeight: FontWeight.w500),
                        ))),
                ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/'),
                    child: Text('Sair'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFff0000),
                        textStyle: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: 30,
                              height: 1,
                              fontWeight: FontWeight.w500),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
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
