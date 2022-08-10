import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/firebase_auth_errors.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestAccessHistory extends StatefulWidget {
  RequestAccessHistory({Key? key}) : super(key: key);

  @override
  State<RequestAccessHistory> createState() => _RequestAccessHistoryState();
}

class _RequestAccessHistoryState extends State<RequestAccessHistory> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;

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
                        if (!errorMessage.isEmpty) ...[
                          verticalGap,
                          AutoSizeText(
                            errorMessage,
                            style: GoogleFonts.vt323(
                                textStyle: TextStyle(
                                    fontSize: 21.8,
                                    fontWeight: FontWeight.w500),
                                color: buttonColor,
                                shadows: <Shadow>[
                                  Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, 0),
                                      blurRadius: 20),
                                ]),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ],
                        verticalGap,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              usableButton(context, 'VOLTAR', () {
                                GoRouter.of(context).go('/menu/history');
                              }, 190.0),
                              horizontalGap,
                              usableButton(context, 'ENVIAR', () async {
                                errorMessage = '';
                                setState(() => isLoading = true);
                                if (_key.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: '123');
                                  } on FirebaseAuthException catch (error) {
                                    if (error.code == 'wrong-password') {
                                      String message =
                                          await updateHistoryRequest(
                                              _emailController.text);
                                      errorMessage = message;
                                    } else {
                                      errorMessage = errors[error.code]!;
                                    }
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
