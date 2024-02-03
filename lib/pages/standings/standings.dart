import 'package:apl_admin/helper/widgets/app_bar.dart';
import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/helper/widgets/future_builder.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/helper/widgets/text.dart';
import 'package:apl_admin/requests/season.dart';
import 'package:apl_admin/requests/standings.dart';
import 'package:flutter/material.dart';


class Standings extends StatefulWidget {
  const Standings(
    {
      super.key
    }
  );

  @override
  StandingsState createState() => StandingsState();
}

class StandingsState extends State<Standings> {
  
  Map<String, dynamic> _selectedSeason = {};
  List<Map<String, dynamic>> _seasons = [];

  @override
  void initState() {
    super.initState();
    getSeasons().then((seasons) {
      if (seasons.isNotEmpty) {
        setState(() {
          _seasons = seasons;
          _selectedSeason = seasons[0];
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    List<String> seasonDropdownItems =
        _seasons.map((season) => season['name'] as String).toList();

    AppDropDownButton seasonDropDown = AppDropDownButton(
      items: seasonDropdownItems,
      selectedValue: _selectedSeason['name'],
      onChanged: (value) {
        setState(() {
          _selectedSeason =
              _seasons.firstWhere((season) => season['name'] == value);
        });
      },
    );
    
    return Column(
      children: [
        AppFutureBuilder(
          future: getSeasons(),
          builder: (data) {
            return seasonDropDown;
          },
          errorText: "seasons",
        ),

        const SizedBox(height: 20),

        ListViewHeading(
          heading: "Standings",
          buttonText: "Create Standings",
          onPressed:  () {
            showDialog(
              context: context, 
              builder: (BuildContext context){
                return AddStandingsDialogBox(
                  seasons: _seasons,
                );
              }
            );
          }
        ),

        // Check if _selectedSeason is available before building the results
        if (_selectedSeason.isNotEmpty)

          Expanded(
            child: AppFutureBuilder(
              future: getSeasonStandings(_selectedSeason['id'] as int),
              builder: (data) {
                
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return StandingsTile(
                      standings: data[index],
                    );
                  },
                );
                
               
              },
              errorText: "standings",
            ),
              
          ),

          
              
      ]
    );
  }

}

class ViewStandings extends StatefulWidget {
  const ViewStandings(
    {
      super.key,
      required this.standings
    }
  );

  final dynamic standings;
  
  @override
  ViewStandingsState createState() => ViewStandingsState();
}

class ViewStandingsState extends State<ViewStandings> {
  Widget buildStandingsList(String header, List standingsTeams) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CenteredText(
          text: HeaderText(
            text: header,
          ),
        ),
        StandingsTable(standingsTeams: standingsTeams),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: RegularAppBar(
          prevContext: context,
          title: "View Standings",
        ),
        body: Column(
          children: [
            if (widget.standings is Map)
              buildStandingsList("Premier League", widget.standings['standings_teams'])
            else if (widget.standings is List)
              Column(
                children: [
                  buildStandingsList("FA Cup", widget.standings[0]['standings_teams']),
                  const SizedBox(height: 20),
                  buildStandingsList("FA Cup", widget.standings[1]['standings_teams']),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
