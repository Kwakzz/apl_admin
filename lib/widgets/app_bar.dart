import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text.dart';


// ignore: must_be_immutable
class AppBarWithPrevButton extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String title;
  Color color;

  final BuildContext prevContext;

  AppBarWithPrevButton(
    {
      super.key, 
      required this.prevContext,
      required this.title,
      this.color = const Color.fromARGB(255, 197, 50, 50),
    }
  );

  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText(
        text: title,
        color: Colors.white,
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 15,
        ),
        onPressed: () {
          Navigator.of(prevContext).pop(); 
        },
        iconSize: 15,
      ),
      backgroundColor: color
    );
  }
}


class AppBarWithNoPrevButton extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String title;

  const AppBarWithNoPrevButton(
    {
      super.key, 
      required this.title,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText(
        text: title,
        fontWeight: FontWeight.w700,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}


class AppBarWithAPLLogo extends StatelessWidget implements PreferredSizeWidget {

  const AppBarWithAPLLogo(
    {
      super.key, 
    }
  );

  @override
  Size get preferredSize => const Size.fromHeight(80);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        children: [
          Image.asset(
            "assets/menu_rectangle.jpg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                'Ashesi Premier League',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AppBarWithNavButton extends StatelessWidget implements PreferredSizeWidget {

  const AppBarWithNavButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = const Color.fromARGB(255, 197, 50, 50),
  });

  final String title;
  final Function onPressed;
  final Color color;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText(
        text: title,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 15,
        ),
        onPressed: () {
          onPressed();
        },
        iconSize: 15,
      ),
      backgroundColor: color
    );
  }

}