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
  final String? Function(String?)? validator;

  const UiTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    TextStyle kTextStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: kTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        ),
        validator: validator,
      ),
    );
  }
}


