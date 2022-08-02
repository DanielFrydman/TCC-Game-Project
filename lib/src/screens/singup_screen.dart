import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:game_template/src/shared/firebase_auth_errors.dart';
import 'package:game_template/src/shared/reusable_widget.dart';
import 'package:game_template/src/settings/settings.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _managerCode = TextEditingController();
  final _cleanedManagerCode = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;
  bool _passwordVisible = true;
  bool? _checkedValue = false;

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
                              "Nome do Usuário",
                              Icons.account_box_rounded,
                              false,
                              _usernameController,
                              validateUsername),
                        ),
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
                                _passwordController, validateCreatePassword,
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
                        verticalGap,
                        Row(
                          children: [
                            if (_checkedValue == false) ...[
                              SizedBox(
                                width: 400,
                                child: CheckboxListTile(
                                  title: reusableTextField(
                                    "Você é um Gestor?",
                                    Icons.account_circle,
                                    false,
                                    _cleanedManagerCode,
                                    returnNullValidation,
                                    enabled: false),
                                  value: _checkedValue,
                                  activeColor: buttonColor,
                                  contentPadding: EdgeInsets.all(0),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkedValue = newValue;
                                    });
                                  },
                                ),
                              ),
                            ] else ...[
                              SizedBox(
                                width: 400,
                                child: CheckboxListTile(
                                  title: reusableTextField(
                                      "Código de Gestor",
                                      Icons.account_circle,
                                      false,
                                      _managerCode,
                                      validateManagerCode),
                                  value: _checkedValue,
                                  activeColor: buttonColor,
                                  contentPadding: EdgeInsets.all(0),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkedValue = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                        verticalGap,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              usableButton(context, 'VOLTAR', () {
                                GoRouter.of(context).go('/');
                              }, 190.0),
                              horizontalGap,
                              usableButton(context, 'CRIAR CONTA', () async {
                                errorMessage = '';
                                setState(() => isLoading = true);
                                if (_key.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);

                                    context
                                        .read<SettingsController>()
                                        .setPlayerName(capitalize(
                                            _usernameController.text));

                                    createNewCollectionForNewAccount(
                                      capitalize(_usernameController.text),
                                      _emailController.text,
                                      _checkedValue
                                    );

                                    GoRouter.of(context).go('/menu');
                                  } on FirebaseAuthException catch (error) {
                                    errorMessage = errors[error.code]!;
                                  }
                                }
                                setState(() => isLoading = false);
                              }, 190.0, isLoading: isLoading),
                            ]),
                        verticalGap,
                        if (!errorMessage.isEmpty) ...[
                          verticalGap,
                          Text(
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
                      ],
                    ),
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
