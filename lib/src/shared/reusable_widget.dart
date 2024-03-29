import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, validator,
    {suffixIcon = null,
    passwordVisible = false,
    enabled = true,
    readOnly = false}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: passwordVisible,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    enabled: enabled,
    readOnly: readOnly,
    textCapitalization: text == 'Nome do Usuário'
        ? TextCapitalization.words
        : TextCapitalization.none,
    cursorColor: Colors.white,
    style: GoogleFonts.vt323(
        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
        color: Colors.white.withOpacity(0.9),
        shadows: <Shadow>[
          Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 20)
        ]),
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: Icon(icon, color: Colors.white),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.black.withOpacity(0.85),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      errorStyle: GoogleFonts.vt323(
          textStyle: TextStyle(fontSize: 21.5, fontWeight: FontWeight.w500),
          color: buttonColor,
          shadows: <Shadow>[
            Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 20),
          ]),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container usableButton(BuildContext context, text, Function onTap, width,
    {bool isLoading = false}) {
  return Container(
    width: width,
    height: 50,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: GoogleFonts.vt323(
                textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonColor.withOpacity(0.6);
            }

            return buttonColor.withOpacity(0.85);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
    ),
  );
}

double responsiveFontSize(context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  if (width < 1000 || height < 500) {
    return 60;
  } else if (width < 1200 || height < 600) {
    return 70;
  } else if (width < 1400 || height < 800) {
    return 75;
  }

  return 100;
}

String? validateManagerCode(String? managerCode) {
  if (managerCode == "") return '''Se você é gestor, insira o código.''';
  if (managerCode != "SOUGESTOR@ASI2022") return '''Código inválido.''';

  return null;
}

String? returnNullValidation(String? cleanedManagerCode) {
  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) return 'Insira seu e-mail.';

  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(formEmail);

  if (emailValid) {
    return null;
  }

  return 'E-mail inválido.';
}

String? validateCreatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Insira sua senha.';
  }

  if (formPassword.length < 6) {
    return 'Sua senha deve ter pelo menos 6 dígitos.';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(formPassword)) {
    return '''Escolha uma senha mais segura. Use uma com-
binação de letras maiúsculas, minúsculas,
números e símbolos.''';
  }

  return null;
}

String? validateUsername(String? formUsername) {
  if (formUsername == null || formUsername.isEmpty) return 'Insira seu nome.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Insira sua senha.';
  }

  return null;
}

String capitalize(string) {
  return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
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

SizedBox gap(double) {
  return SizedBox(height: double);
}

const verticalGap = SizedBox(
  height: 20,
);

const verticalHalfGap = SizedBox(
  height: 5,
);

const horizontalGap = SizedBox(
  width: 20,
);

const horizontalHalfGap = SizedBox(
  width: 5,
);

const buttonColor = Color(0xFF0000FF);

String formatDate(date) {
  if (date.runtimeType != DateTime) {
    return '    -';
  }

  final DateFormat dayMonthYearFormat = DateFormat('dd/MM/yyyy');
  final DateFormat hourMinuteFormat = DateFormat('Hm');

  return "${dayMonthYearFormat.format(date)} às ${hourMinuteFormat.format(date)}";
}

Text text(text, context, {size = 1}) {
  return Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.vt323(
          textStyle: TextStyle(
              fontSize: responsiveFontSize(context) / size,
              fontWeight: FontWeight.w300)));
}

TextStyle textStyle(context, {size = 1}) {
  return GoogleFonts.vt323(
      textStyle: TextStyle(
          fontSize: responsiveFontSize(context) / size,
          fontWeight: FontWeight.w300));
}

TextStyle textStyleWithShadow(context, {size = 1}) {
  return GoogleFonts.vt323(
      textStyle: TextStyle(
          fontSize: responsiveFontSize(context) / size,
          fontWeight: FontWeight.w300,
          shadows: <Shadow>[
        Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 30)
      ]));
}

DataTable dataTable(columns, rows, {dataRowHeight = 140.0}) {
  return DataTable(
    headingRowColor: MaterialStateColor.resolveWith(
        (states) => Colors.white.withOpacity(0.8)),
    dataRowColor: MaterialStateColor.resolveWith(
        (states) => Colors.white.withOpacity(0.8)),
    headingTextStyle: GoogleFonts.vt323(
        textStyle: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w300, color: Colors.black)),
    dataTextStyle: GoogleFonts.vt323(
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.w300, color: Colors.black)),
    dataRowHeight: dataRowHeight,
    columns: columns,
    rows: rows,
  );
}

ElevatedButton button(context, text, route) {
  return ElevatedButton(
      onPressed: () => GoRouter.of(context).go(route),
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: buttonColor, textStyle: textStyle(context, size: 2)));
}

ElevatedButton buttonUserHistory(context, text, email) {
  return ElevatedButton(
      onPressed: () => GoRouter.of(context)
          .goNamed('userHistory', params: {'email': '${email}'}),
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: buttonColor, textStyle: textStyle(context, size: 2)));
}

requestedAccessModal(context, email) async {
  await Future.delayed(Duration(microseconds: 1));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 130, maxWidth: 600),
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Deseja conceder acesso ao seu histórico?",
                          style: GoogleFonts.vt323(
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                        )),
                    verticalGap,
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          // border: BoxBorder.lerp(null, null, 10.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              text(email, context, size: 2),
                              ElevatedButton(
                                  onPressed: () {
                                    removeManagerFromHistoryRequest(email);
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('Não'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      textStyle: textStyle(context, size: 2))),
                              ElevatedButton(
                                  onPressed: () {
                                    removeManagerFromHistoryRequest(email);
                                    updateHistoryAccess(email);
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('Sim'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      textStyle: textStyle(context, size: 2)))
                            ],
                          ),
                        ])),
                  ],
                )),
          ),
        );
      });
}
