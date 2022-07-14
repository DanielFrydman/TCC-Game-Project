import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/audio/audio_controller.dart';
import 'package:game_template/src/games_services/games_services.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgrounds[getBackgroundForDayTime()]),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.rotate(
                angle: -0.1,
                child: AutoSizeText(
                  'Aprendendo Segurança da Informação!',
                  style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        fontSize: responsiveFontSize(context),
                        height: 1,
                        fontWeight: FontWeight.w600,
                        shadows: <Shadow>[
                          Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 30)
                        ]),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/signIn'),
                    // audioController.playSfx(SfxType.buttonTap);
                    child: Text(
                      'Fazer Login',
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFff0000),
                        textStyle: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: responsiveFontSize(context) / 2,
                              height: 1,
                              fontWeight: FontWeight.w500),
                        ))),
                // ElevatedButton(
                //     onPressed: () => GoRouter.of(context).go('/menu/settings'),
                //     child: Text('Configurações'),
                //     style: ElevatedButton.styleFrom(
                //         primary: Color(0xFFff0000),
                //         textStyle: GoogleFonts.vt323(
                //           textStyle: TextStyle(
                //               fontSize: responsiveFontSize(context) / 2,
                //               height: 1,
                //               fontWeight: FontWeight.w500),
                //         ))),
                ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/signUp'),
                    child: Text('Criar Conta'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFff0000),
                        textStyle: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: responsiveFontSize(context) / 2,
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
}
