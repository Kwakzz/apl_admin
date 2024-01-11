// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text.dart';


/// Class for creating a form field.
class AppFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  bool obscureText = false;
  final FormFieldValidator <String>?  validator;
  final TextInputType? keyboardType;
  final bool enabled;
  Widget? suffixIcon;
  bool readOnly;
  final void Function()? onTap;
  

  AppFormField({
    super.key, 
    required this.controller,
    required this.hintText,
    this.labelText,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(top: 6, bottom: 15),
        child: TextFormField (
          maxLines: null,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey,
            ),
            labelText: labelText,
            labelStyle: GoogleFonts.roboto(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          style: GoogleFonts.roboto(
            fontSize: 12,
            color: Colors.black,
          ),
          validator: validator,
          enabled: enabled,
          onTap: onTap
        ),
      )
    );
  }
}


/// Class for creating a form field for passwords.  
class PasswordFormField extends StatefulWidget {

  final TextEditingController controller;
  final FormFieldValidator <String>?  validator;

  const PasswordFormField({
    super.key, 
    required this.controller,
    this.validator
  });

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();


}

class PasswordFormFieldState extends State <PasswordFormField> {

  bool obscureText = true;


  @override
  Widget build(BuildContext context) {
    return AppFormField(
      controller: widget.controller, 
      obscureText: obscureText,
      hintText: "Password must be at least 8 characters long",
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
          size: 16,
        ),
      ),
    );
  }


}


/// Class for creating a button for submitting forms.
class SubmitFormButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;

  const SubmitFormButton({
    super.key, 
    required this.text,
    this.onPressed,
    this.color = const Color.fromRGBO(197, 50, 50, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Container(
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: color
          ),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )
    );
  }
}



class AppDropDownButton extends StatelessWidget {

  String? selectedValue;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? hintText;
  final FormFieldValidator <String>?  validator;

  AppDropDownButton({
    super.key, 
    this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(top: 6, bottom: 15),
        child: DropdownButtonFormField(
          value: selectedValue,
          items: items.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: RegularText(
                text: value,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          validator: validator,
        ),
      )
    );
  }

}

class UploadImageButton extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const UploadImageButton({
    super.key, 
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Container(
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        width: MediaQuery.of(context).size.width * 0.3,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black87
          ),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      )
    );
  }
}