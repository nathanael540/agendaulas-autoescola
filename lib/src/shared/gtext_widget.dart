import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GText extends StatelessWidget {
  const GText(this.text,
      {Key? key, this.italic, this.fontSize, this.color, this.fontWeight})
      : super(key: key);

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? italic;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              decoration: TextDecoration.none,
              color: color ?? Colors.black87,
              fontSize: fontSize ?? 16.0,
              fontStyle: italic ?? FontStyle.normal,
              fontWeight: fontWeight ?? FontWeight.w400)),
    );
  }
}
