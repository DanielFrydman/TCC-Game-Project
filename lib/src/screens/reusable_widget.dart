import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    cursorHeight: 25,
    style: GoogleFonts.vt323(
        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
        color: Colors.white.withOpacity(0.9),
        shadows: <Shadow>[
          Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 20)
        ]),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: Colors.black.withOpacity(0.85),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container usableButton(BuildContext context, text, Function onTap, width) {
  return Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
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
              return Color(0xFFff0000).withOpacity(0.6);
            }

            return Color(0xFFff0000).withOpacity(0.85);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
    ),
  );
}

double responsiveFontSize(context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;


  if (width < 1000 && height < 500) {
    return 60;
  } else if (width < 1200 && height < 600) {
    return 70;
  } else if (width < 1400 && height < 800) {
    return 75;
  } 
  
  return 100;
}