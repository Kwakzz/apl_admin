// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// This class is used to create a text widget for headings.
class HeaderText extends StatelessWidget {
  
  const HeaderText ({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w600,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

}


/// This class is used to create a text widget for sub headings.
class SubHeaderText extends StatelessWidget {
  
  const SubHeaderText ({
    super.key,
    required this.text,
    this.color = Colors.black,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 13,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }

}


/// This class is used to create a text widget for regular text.
class RegularText extends StatelessWidget {
  
  RegularText ({
    super.key,
    required this.text,
    this.color
  });

  final String text;
  Color? color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w300,
      ),
    );
  }

}


/// This class is used to create a text widget for left-aligned regular text.
class LeftAlignedText extends StatelessWidget {
  
  const LeftAlignedText ({
    super.key,
    required this.text,
  });

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: text
      )
    );
  }

}


/// This class is used to create a text widget for a centered regular text.
class CenteredText extends StatelessWidget {
  
  const CenteredText ({
    super.key,
    required this.text,
  });

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.center,
        child: text
      )
    );
  }

}


class LinkText extends StatelessWidget {
  
  const LinkText ({
    super.key,
    required this.text,
    required this.onTap,
  });

  final Widget text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: text,
    );
  }

}

