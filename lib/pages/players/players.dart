import 'package:apl_admin/helper/widgets/future_builder.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/pages/players/create_player.dart';
import 'package:apl_admin/requests/players.dart';
import 'package:flutter/material.dart';

class Players extends StatefulWidget {
  const Players({
     super.key,
  });

  @override
  PlayersState createState() => PlayersState();

}

class PlayersState extends State<Players> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [

          const SizedBox(
            height: 15,
          ),

          ListViewHeading(
            heading: "Players", 
            buttonText: "Add Player", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePlayer()),
              );
            }
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getPlayers(), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return PlayerTile(
                      player: data[index],
                    );
                  },
                );
              }, 
              errorText: "players"
            )
          ),
        ],
      ),
    );
  }
}
