import 'package:flutter/material.dart';
import 'package:game_template/src/screens/reusable_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

const _verticalGap = SizedBox(
  height: 20,
);

const _verticalHalfGap = SizedBox(
  height: 5,
);

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage(backgrounds[getBackgroundForDayTime()]),
                        fit: BoxFit.cover))),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    // padding: new EdgeInsets.only(top: 50),
                    child: Transform.rotate(
                      angle: -0.1,
                      child: Text(
                        'Aprendendo\nSegurança da\nInformação!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(
                              fontSize: 55,
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
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        child: reusableTextField("Email", Icons.account_circle,
                            false, emailController),
                      ),
                      _verticalGap,
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        child: reusableTextField(
                            "Senha", Icons.lock, true, passwordController),
                      ),
                      _verticalGap,
                      usableButton(context, 'Entrar', () {
                        GoRouter.of(context).go('/menu');
                      }, MediaQuery.of(context).size.width / 2.5),
                      _verticalHalfGap,
                      signUpOption()
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não tem conta? ",
          style: GoogleFonts.vt323(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/signUp');
            },
            child: Text(
              "Criar conta",
              style: GoogleFonts.vt323(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
      ],
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
