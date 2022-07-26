import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../in_app_purchase/in_app_purchase.dart';
import '../player_progress/player_progress.dart';
import '../style/responsive_screen.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: ResponsiveScreen(
          squarishMainArea: Column(
            children: [
              Text(
                'Configurações',
                textAlign: TextAlign.center,
                style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        fontSize: responsiveFontSize(context),
                        fontWeight: FontWeight.w300,
                        shadows: <Shadow>[
                      Shadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                          blurRadius: 30)
                    ])),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (FirebaseAuth.instance.currentUser != null) ...[
                      const _NameChangeLine(
                        'Nome',
                      )
                    ],
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
                    if (FirebaseAuth.instance.currentUser != null) ...[
                      _SettingsLine(
                        'Redefinir progresso',
                        Image.asset('assets/images/buttons/restart.png',
                            scale: 0.5),
                        onSelected: () {
                          if (playerProgress.highestLevelReached > 0) {
                            context.read<PlayerProgress>().reset();
                            updateHistoryFromUser(reseted: true);

                            final messenger = ScaffoldMessenger.of(context);
                            messenger.showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'O progresso do jogador foi redefinido.',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300)))),
                            );
                          } else {
                            final messenger = ScaffoldMessenger.of(context);
                            messenger.showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Você ainda está no primeiro nível...',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300)))),
                            );
                          }
                        },
                      ),
                    ],
                    _SettingsLine(
                      'Créditos',
                      Image.asset('assets/images/buttons/credits.png',
                          scale: 0.5),
                      onSelected: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => _Credits()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser != null
                        ? GoRouter.of(context).go('/menu')
                        : GoRouter.of(context).go('/');
                  },
                  child: Text('Voltar'),
                  style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      textStyle: GoogleFonts.vt323(
                        textStyle: TextStyle(
                            fontSize: responsiveFontSize(context) / 2,
                            fontWeight: FontWeight.w300),
                      ))),
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
                '$name',
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

class _Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: ResponsiveScreen(
          squarishMainArea: Column(
            children: [
              Text(
                'Créditos',
                textAlign: TextAlign.center,
                style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        fontSize: responsiveFontSize(context),
                        fontWeight: FontWeight.w300,
                        shadows: <Shadow>[
                      Shadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                          blurRadius: 30)
                    ])),
              ),
              Expanded(
                child: ListView(
                  children: [
                    InkResponse(
                      highlightShape: BoxShape.rectangle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Sprites         - ',
                                    style: GoogleFonts.vt323(
                                        textStyle: TextStyle(
                                            fontSize:
                                                responsiveFontSize(context) /
                                                    2.5,
                                            fontWeight: FontWeight.w300))),
                                GestureDetector(
                                  child: Text('https://limezu.itch.io/',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(context) /
                                                      2.5,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.pink,
                                              decoration:
                                                  TextDecoration.underline))),
                                  onTap: () async {
                                    var url =
                                        Uri.parse('https://limezu.itch.io/');
                                    if (await canLaunchUrl(url)) launchUrl(url);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Música          - ',
                                    style: GoogleFonts.vt323(
                                        textStyle: TextStyle(
                                            fontSize:
                                                responsiveFontSize(context) /
                                                    2.5,
                                            fontWeight: FontWeight.w300))),
                                GestureDetector(
                                  child: Text(
                                      'https://opengameart.org/users/zane-little-music',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(context) /
                                                      2.5,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.pink,
                                              decoration:
                                                  TextDecoration.underline))),
                                  onTap: () async {
                                    var url = Uri.parse(
                                        'https://opengameart.org/users/zane-little-music');
                                    if (await canLaunchUrl(url)) launchUrl(url);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Planos de Fundo - ',
                                    style: GoogleFonts.vt323(
                                        textStyle: TextStyle(
                                            fontSize:
                                                responsiveFontSize(context) /
                                                    2.5,
                                            fontWeight: FontWeight.w300))),
                                GestureDetector(
                                  child: Text(
                                      'https://digitalmoons.itch.io/pixel-skies-demo',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(context) /
                                                      2.5,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.pink,
                                              decoration:
                                                  TextDecoration.underline))),
                                  onTap: () async {
                                    var url = Uri.parse(
                                        'https://digitalmoons.itch.io/pixel-skies-demo');
                                    if (await canLaunchUrl(url)) launchUrl(url);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Ícones          - ',
                                    style: GoogleFonts.vt323(
                                        textStyle: TextStyle(
                                            fontSize:
                                                responsiveFontSize(context) /
                                                    2.5,
                                            fontWeight: FontWeight.w300))),
                                GestureDetector(
                                  child: Text(
                                      'https://blackdragon1727.itch.io/',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(context) /
                                                      2.5,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.pink,
                                              decoration:
                                                  TextDecoration.underline))),
                                  onTap: () async {
                                    var url = Uri.parse(
                                        'https://blackdragon1727.itch.io/');
                                    if (await canLaunchUrl(url)) launchUrl(url);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Alguns Efeitos  - ',
                                    style: GoogleFonts.vt323(
                                        textStyle: TextStyle(
                                            fontSize:
                                                responsiveFontSize(context) /
                                                    2.5,
                                            fontWeight: FontWeight.w300))),
                                GestureDetector(
                                  child: Text('https://nyknck.itch.io/',
                                      style: GoogleFonts.vt323(
                                          textStyle: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(context) /
                                                      2.5,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.pink,
                                              decoration:
                                                  TextDecoration.underline))),
                                  onTap: () async {
                                    var url =
                                        Uri.parse('https://nyknck.itch.io/');
                                    if (await canLaunchUrl(url)) launchUrl(url);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go('/menu');
                  },
                  child: Text('Voltar'),
                  style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      textStyle: GoogleFonts.vt323(
                        textStyle: TextStyle(
                            fontSize: responsiveFontSize(context) / 2,
                            fontWeight: FontWeight.w300),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
