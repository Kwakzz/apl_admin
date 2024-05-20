import 'package:apl_admin/util/date_time.dart';
import 'package:apl_admin/widgets/card.dart';
import 'package:apl_admin/widgets/future_builder.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:flutter/material.dart';
import 'create_match.dart';

class Matches extends StatefulWidget {
  
  const Matches({
     super.key,
     required this.matchday,
  });

  final Map<String, dynamic> matchday;  

  @override
  MatchesState createState() => MatchesState();

}

class MatchesState extends State<Matches> {

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
            heading: "Matchday ${widget.matchday['number']} (${formatDateIntoWords(widget.matchday['date'])})", 
            buttonText: "Add Match", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateMatch(matchday: widget.matchday)),
              );
            }
          ),

          const SizedBox(
            height: 25,
          ),

          const LeftAlignedText(
            text: SubHeaderText(
              text: "Tap a match's tile to view the details about that match.",
              color: Colors.black54,
            )
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getMatchdayMatches(widget.matchday['id']), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FixtureCard(
                      fixture: data[index],
                    );
                  },
                );
              }, 
              errorText: "matches"
            )
          ),
        ],
      ),
    );
  }
}
