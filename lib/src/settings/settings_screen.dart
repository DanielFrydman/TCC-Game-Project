// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../in_app_purchase/in_app_purchase.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: ResponsiveScreen(
          squarishMainArea: ListView(
            children: [
              _gap,
              Text(
                'Configurações',
                textAlign: TextAlign.center,
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
              _gap,
              const _NameChangeLine(
                'Nome',
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.soundsOn,
                builder: (context, soundsOn, child) => _SettingsLine(
                  'Efeitos Sonoros',
                  soundsOn
                      ? Image.asset('assets/images/buttons/sound_on.png',
                          scale: 0.5)
                      : Image.asset('assets/images/buttons/sound_off.png',
                          scale: 0.5),
                  onSelected: () => settings.toggleSoundsOn(),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.musicOn,
                builder: (context, musicOn, child) => _SettingsLine(
                  'Música',
                  musicOn
                      ? Image.asset('assets/images/buttons/music_on.png',
                          scale: 0.5)
                      : Image.asset('assets/images/buttons/music_off.png',
                          scale: 0.5),
                  onSelected: () => settings.toggleMusicOn(),
                ),
              ),
              Consumer<InAppPurchaseController?>(
                  builder: (context, inAppPurchase, child) {
                if (inAppPurchase == null) {
                  // In-app purchases are not supported yet.
                  // Go to lib/main.dart and uncomment the lines that create
                  // the InAppPurchaseController.
                  return const SizedBox.shrink();
                }

                Widget icon;
                VoidCallback? callback;
                if (inAppPurchase.adRemoval.active) {
                  icon = const Icon(Icons.check);
                } else if (inAppPurchase.adRemoval.pending) {
                  icon = const CircularProgressIndicator();
                } else {
                  icon = const Icon(Icons.ad_units);
                  callback = () {
                    inAppPurchase.buy();
                  };
                }
                return _SettingsLine(
                  'Remover Ads',
                  icon,
                  onSelected: callback,
                );
              }),
              _SettingsLine(
                'Redefinir progresso',
                Image.asset('assets/images/buttons/restart.png', scale: 0.5),
                onSelected: () {
                  context.read<PlayerProgress>().reset();

                  final messenger = ScaffoldMessenger.of(context);
                  messenger.showSnackBar(
                    SnackBar(
                        content: Text('O progresso do jogador foi redefinido.',
                            style: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300)))),
                  );
                },
              ),
              _gap,
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: Text('Voltar',
                    style: GoogleFonts.vt323(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300))),
              ),
              _gap,
            ],
          ),
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: GoogleFonts.vt323(
                    textStyle:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w300))),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: GoogleFonts.vt323(
                    textStyle:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w300)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: GoogleFonts.vt323(
                    textStyle:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w300))),
            const Spacer(),
            icon,
          ],
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
