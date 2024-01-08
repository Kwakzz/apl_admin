import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// This button is displayed in on the "More" tab's page when a user isn't logged in. It contains the words, "Register/Sign In". It navigates the user to the Register/Sign In page.
class JoinUsButton extends StatelessWidget {

  /// This button is displayed in on the "More" tab's page when a user isn't logged in. It contains the words, "Register/Sign In". It navigates the user to the Register/Sign In page.
  const JoinUsButton({
    super.key,
    required this.onPressed,
  });

  final Function () onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Register/Sign In",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 197, 50, 50),
          ),
        ),
      )
    );
  }

}


/// When you click on the add button, it takes you to a form where you can add a new player, season, fixture, etc.
class AddButton extends StatelessWidget {

  /// When you click on the add button, it takes you to a form where you can add a new player, season, fixture, etc.
  const AddButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function () onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 197, 50, 50),
        ),
      ),
    );
  }
}