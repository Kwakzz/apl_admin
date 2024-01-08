import 'package:apl_admin/helper/widgets/future_builder.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/helper/widgets/text.dart';
import 'package:apl_admin/pages/matchdays/match_days.dart';
import 'package:apl_admin/pages/seasons/create_season.dart';
import 'package:apl_admin/requests/season.dart';
import 'package:flutter/material.dart';

class Seasons extends StatefulWidget {
  const Seasons({
     super.key,
  });

  @override
  SeasonsState createState() => SeasonsState();

}

class SeasonsState extends State<Seasons> {

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
            heading: "Seasons", 
            buttonText: "Add Season", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateSeason()),
              );
            }
          ),

          const SizedBox(
            height: 25,
          ),

          const LeftAlignedText(
            text: SubHeaderText(
              text: "Tap a season's tile to view the matchdays in that season.",
              color: Colors.black54,
            )
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getSeasons(), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return SeasonTile(
                      season: data[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute (
                            builder: (context) => Matchdays(
                            season: data[index])
                          ),
                        );
                      },
                    );
                  },
                );
              }, 
              errorText: "seasons"
            )
          ),
        ],
      ),
    );
  }
}
