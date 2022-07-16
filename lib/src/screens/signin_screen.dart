import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;
  bool _passwordVisible = true;

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
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        verticalGap,
                        verticalGap,
                        SizedBox(
                          width: 400,
                          child: reusableTextField(
                              "Email",
                              Icons.account_circle,
                              false,
                              _emailController,
                              validateEmail),
                        ),
                        verticalGap,
                        SizedBox(
                            width: 400,
                            child: reusableTextField("Senha", Icons.lock, true,
                                _passwordController, validatePassword,
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.only(right: 5),
                                  icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                passwordVisible: _passwordVisible)),
                        if (!errorMessage.isEmpty) ...[
                          verticalGap,
                          AutoSizeText(
                            errorMessage,
                            style: GoogleFonts.vt323(
                              textStyle: TextStyle(
                                  fontSize: 15,
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
                          ),
                        ],
                        verticalGap,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              usableButton(context, 'VOLTAR', () {
                                GoRouter.of(context).go('/');
                              }, 190.0),
                              horizontalGap,
                              usableButton(context, 'ENTRAR', () async {
                                errorMessage = '';
                                setState(() => isLoading = true);
                                if (_key.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);

                                    GoRouter.of(context).go('/menu');
                                  } on FirebaseAuthException catch (error) {
                                    errorMessage = error.message!;
                                  }
                                }
                                setState(() => isLoading = false);
                              }, 190.0, isLoading: isLoading),
                            ]),
                        verticalGap,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
