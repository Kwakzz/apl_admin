import 'package:apl_admin/widgets/app_bar.dart';
import 'package:apl_admin/widgets/list_tile.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/pages/news/news.dart';
import 'package:apl_admin/pages/standings/standings.dart';
import 'package:flutter/material.dart';
import 'players/players.dart';
import 'seasons/seasons.dart' as seasons;



/// Class for Admin page
/// This screen is only accessible to the admin.
/// It allows the admin user to easily add, remove, update or read data from the database.
class Home extends StatefulWidget {

  const Home(
    {
      super.key,
    }
  );

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  String pageName = "Admin";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // selected tile
  String selectedTile = "Players";

  

  @override
  Widget build(BuildContext context) {

    /// This function is called when the user taps on a tile in the drawer.
    /// It changes the selected tile and closes the drawer.
    /// Based on the selected tile, the body of the page is changed.
    Widget getContent() {
      switch (selectedTile) {

        case 'Players':
          return const Players();

        case 'Seasons':
          return const seasons.Seasons();  

        case 'News':
          return const News(); 

        case 'Standings':
          return const Standings();

        default:
          return const Text('No content available');
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      // app bar
      appBar: AppBarWithNavButton(
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Admin",
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color:  Color.fromARGB(255, 197, 50, 50),
              ),

              child: HeaderText(
                text: 'Admin', 
                fontWeight: FontWeight.w600, 
                fontSize: 16, 
                color: Colors.white
              ),

            ),

            DrawerTile(
              title: 'Players',
              icon: Icons.person,
              onTap: () {
                setState(() {
                  selectedTile = 'Players';
                  Navigator.pop(context);
                });
              },
            ),

            DrawerTile(
              title: 'Seasons',
              icon: Icons.calendar_today,
              onTap: () {
                setState(() {
                  selectedTile = 'Seasons';
                  Navigator.pop(context);
                });
              },
            ),

            DrawerTile(
              title: 'News',
              icon: Icons.article,
              onTap: () {
                setState(() {
                  selectedTile = 'News';
                  Navigator.pop(context);
                });
              },
            ),

            DrawerTile(
              title: 'Standings',
              icon: Icons.table_chart,
              onTap: () {
                setState(() {
                  selectedTile = 'Standings';
                  Navigator.pop(context);
                });
              },
            ),

            

          ]
        )
      ),

     

      // body
      // body is a list view. It contains a list of tiles. Each tile is a button.
      // there'll be section of tiles. For example, one section for everything related to users, one section for everything related to games, etc.
      body: getContent()
    );
  }

}