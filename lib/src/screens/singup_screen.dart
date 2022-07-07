import 'package:flutter/material.dart';
import 'package:game_template/src/screens/reusable_widget.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

const _verticalGap = SizedBox(
  height: 20,
);

const _horizontalGap = SizedBox(
  width: 20,
);

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

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
                  Column(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: reusableTextField(
                            "Nome do Usuário",
                            Icons.account_box_rounded,
                            false,
                            usernameController),
                      ),
                      _verticalGap,
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: reusableTextField("Email", Icons.account_circle,
                            false, emailController),
                      ),
                      _verticalGap,
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: reusableTextField(
                            "Senha", Icons.lock, true, passwordController),
                      ),
                      _verticalGap,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            usableButton(context, 'VOLTAR', () {
                              GoRouter.of(context).go('/');
                            }, 190.0),
                            _horizontalGap,
                            usableButton(context, 'CRIAR CONTA', () {
                              GoRouter.of(context).go('/menu');
                            }, 190.0),
                          ])
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
