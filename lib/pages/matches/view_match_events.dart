import 'package:apl_admin/widgets/future_builder.dart';
import 'package:apl_admin/widgets/list_tile.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/controllers/match_event.dart';
import 'package:flutter/material.dart';

class ViewMatchEvents extends StatefulWidget {
  const ViewMatchEvents({
     super.key,
     required this.matchId,
  });

  final int matchId;

  @override
  ViewMatchEventsState createState() => ViewMatchEventsState();

}

class ViewMatchEventsState extends State<ViewMatchEvents> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [

          const SizedBox(
            height: 15,
          ),

          const CenteredText(
            text: HeaderText(
              text: "Match Events",
            )
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getMatchEvents(widget.matchId), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MatchEventTile(
                      matchEvent: data[index],
                    );
                  },
                );
              }, 
              errorText: "match events"
            )
          ),
        ],
      ),
    );
  }
}
