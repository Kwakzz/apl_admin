import 'package:apl_admin/widgets/future_builder.dart';
import 'package:apl_admin/widgets/list_tile.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/pages/matchdays/create_matchday.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:flutter/material.dart';

class Matchdays extends StatefulWidget {
  const Matchdays({
     super.key,
     required this.season,
  });

  final Map<String, dynamic> season;

  @override
  MatchdaysState createState() => MatchdaysState();

}

class MatchdaysState extends State<Matchdays> {

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
            heading: "${widget.season['name']}", 
            buttonText: "Add Matchday", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateMatchDay(season: widget.season,)),
              );
            }
          ),

          const SizedBox(
            height: 25,
          ),

          const LeftAlignedText(
            text: SubHeaderText(
              text: "Tap a matchday's tile to view its fixtures.",
              color: Colors.black54,
            )
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getSeasonMatchdays(widget.season['id']), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MatchDayTile(
                      matchday: data[index],
                    );
                  },
                );
              }, 
              errorText: "matchdays"
            )
          ),
        ],
      ),
    );
  }
}
