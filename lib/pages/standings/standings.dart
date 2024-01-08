import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/helper/widgets/future_builder.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/helper/widgets/text.dart';
import 'package:apl_admin/requests/season.dart';
import 'package:apl_admin/requests/standings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StandingsEntry extends StatefulWidget {
  const StandingsEntry(
    {
      super.key
    }
  );

  @override
  StandingsEntryState createState() => StandingsEntryState();
}

class StandingsEntryState extends State<StandingsEntry> {

  int _currentIndex = 0;

  List<Widget> widgetOptions = [
    const MensStandings(),
    const WomensStandings()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    List<BottomNavigationBarItem> bottomNavBarItems = [
      const BottomNavigationBarItem(
        label: "Men",        
        activeIcon: Icon(
          Icons.male,
        ),
        icon: Icon(
          Icons.male,
          color: Color.fromARGB(255, 217, 189, 189),
        ),
      ),
      const BottomNavigationBarItem(
        label: "Women",
        activeIcon: Icon(
          Icons.female,
          color: Colors.white
        ),
        icon: Icon(
          Icons.female,
          color: Color.fromARGB(255, 217, 189, 189),
        ),
      ),
      
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: bottomNavBarItems,
          selectedLabelStyle: GoogleFonts.roboto(
            fontSize: 9,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: GoogleFonts.roboto(
            fontSize: 9,
            fontWeight: FontWeight.w400,
          ),
          selectedIconTheme: const IconThemeData(
            size: 24,
          ),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 217, 189, 189),
          backgroundColor: const Color.fromARGB(255, 197, 50, 50)

        ),
      ),
    );
  }

}


class MensStandings extends StatefulWidget {
  const MensStandings(
    {
      super.key
    }
  );

  @override
  MensStandingsState createState() => MensStandingsState();
}

class MensStandingsState extends State<MensStandings> {
  
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

  Future<List<dynamic>> _getStandings() async {

    List<Map<String, dynamic>> faCupStandings = await getSeasonMensFACupCompStandings(_selectedSeason['id']);

    Map<String, dynamic> leagueStandings = await getSeasonMensLeagueStandings(_selectedSeason['id']);
    
    return [leagueStandings, faCupStandings];

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

        // Check if _selectedSeason is available before building the results
        if (_selectedSeason.isNotEmpty)

          Expanded(
            child: AppFutureBuilder(
              future: _getStandings(),
              builder: (data) {

                Map<String, dynamic> leagueStandings = data[0];
                List<Map<String, dynamic>> faCupStandings = data[1];
                
                if (leagueStandings.isEmpty && faCupStandings.isEmpty) {
                  return Center(
                    child: RegularText(
                      text: "No standings found.",
                      color: Colors.black,
                    ),
                  );
                }

                if (leagueStandings.isNotEmpty && faCupStandings.isEmpty) {
                  return ListView(
                    children: [

                      const CenteredText(
                        text: HeaderText(
                          text: "Premier League",
                        )
                      ),

                      StandingsTable(
                        standingsTeams: leagueStandings['standings_teams']
                      ),
                    ]
                  );
                  
                }

                if (leagueStandings.isEmpty && faCupStandings.isNotEmpty) {
                  
                  return ListView(
                    children: [

                      const CenteredText(
                        text: HeaderText(
                          text: "FA Cup",
                        )
                      ),

                      StandingsTable(
                        standingsTeams: faCupStandings[0]['standings_teams']
                      ),

                      const SizedBox(height: 20),

                      StandingsTable(
                        standingsTeams: faCupStandings[1]['standings_teams']
                      ),
                      
                    ]
                  );
                }

              },
              errorText: "standings",
            ),
              
          ),

          SubmitFormButton(
            text: "Submit",
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AddStandingsDialogBox(
                    seasons: _seasons,
                  );
                }
              );
            }
          )
              
      ]
    );
  }

}


class WomensStandings extends StatefulWidget {
  const WomensStandings(
    {
      super.key
    }
  );

  @override
  WomensStandingsState createState() => WomensStandingsState();
}

class WomensStandingsState extends State<WomensStandings> {
  
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

        // Check if _selectedSeason is available before building the results
        if (_selectedSeason.isNotEmpty)

          Expanded(
            child: AppFutureBuilder(
              future: getSeasonWomensLeagueStandings(_selectedSeason['id']),
              builder: (data) {

                Map<String, dynamic> leagueStandings = data;
                
                if (leagueStandings.isEmpty) {
                  return Center(
                    child: RegularText(
                      text: "No standings found.",
                      color: Colors.black,
                    ),
                  );
                }

                return ListView(
                  children: [

                    const CenteredText(
                      text: HeaderText(
                        text: "Premier League",
                      )
                    ),

                    StandingsTable(
                      standingsTeams: leagueStandings['standings_teams']
                    ),
                  ]
                );
                  
                

              },
              errorText: "standings",
            ),
              
          ),

          SubmitFormButton(
            text: "Submit",
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AddStandingsDialogBox(
                    seasons: _seasons,
                  );
                }
              );
            }
          )
                
      ]
      
    );
  }

}