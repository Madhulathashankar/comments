import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiText extends StatefulWidget {
  final String sTextName;
  final double dTextSize;
  final Color colorOfText;
  final int iBoldness;
  const UiText({
    super.key,
    required this.sTextName,
    required this.dTextSize,
    required this.colorOfText,
    required this.iBoldness,
  });

  @override
  State<UiText> createState() => _UiTextState();
}

class _UiTextState extends State<UiText> {
  FontWeight getFontWeight() {
    switch (widget.iBoldness) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w700;
      default:
        return FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = getFontWeight();

    TextStyle kTextStyle = GoogleFonts.poppins(
      fontSize: widget.dTextSize,
      color: widget.colorOfText,
      fontWeight: fontWeight,
    );

    return Text(
      widget.sTextName,
      style: kTextStyle,
    );
  }
}

class UiTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const UiTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 15.0),
      child: CupertinoTextField(
        controller: controller,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        placeholder: hintText,
        placeholderStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}

