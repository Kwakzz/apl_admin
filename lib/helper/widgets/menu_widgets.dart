// ignore_for_file: must_be_immutable
import 'package:apl_admin/helper/functions/date_time.dart';
import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/text.dart';
import 'package:apl_admin/pages/matches/match.dart';
import 'package:apl_admin/pages/matches/matches.dart';
import 'package:apl_admin/pages/news/view_news.dart';
import 'package:apl_admin/requests/standings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'special_button.dart';


/// Create a list tile for the drawer.
class DrawerTile extends StatelessWidget {

  /// Create a list tile for the drawer.
  const DrawerTile(
    {
      super.key, 
      required this.title,
      required this.icon,
      required this.onTap,
    }
  );

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.black,
        size: 12,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}


/// This widget is used to create a list tile for the players list.
class PlayerTile extends StatelessWidget {

  /// This widget is used to create a list tile for the players list.
  PlayerTile(
    {
      super.key, 
      required this.player
    }
  );

  Map<String, dynamic> player;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
            style: BorderStyle.solid
          )
        )
      ),
      child: ListTile(
        title: Text(
          '${player["first_name"]} ${player["last_name"]}',
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          player["team"]['name'],
          style: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        leading: Image.network(
          player["image"] ?? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
          width: 50,
          height: 50,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error, color: Colors.white,);
          },
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "edit",
                child: RegularText(text: "Edit"),
              ),
              PopupMenuItem(
                value: "transfer",
                child: RegularText(text: "Transfer"),
              )
            ];
          },
          onSelected: (value) {
            switch (value) {
              case "edit":
                break;

              case "transfer":
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return TransfersDialogBox(
                      player: player
                    );
                  }
                );

              default: break;
            }
          },
        ),
        onTap: () {
          
        },
      )
    );
  }
}


/// This widget is used to create a list tile for the seasons list.
class SeasonTile extends StatelessWidget {

  /// This widget is used to create a list tile for the seasons list.
  SeasonTile(
    {
      super.key, 
      required this.season,
      required this.onTap
    }
  );

  Map<String, dynamic> season;
  final Function () onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: Text(
          season["name"],
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '${formatDateIntoWords(season["start_date"])} - ${formatDateIntoWords(season["end_date"])}',
          style: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "edit",
                child: RegularText(text: "Edit"),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case "edit":
                break;
              default:
            }
          },
        ),
        onTap: onTap
      )
    );
  }
}


/// This widget is used to create a list tile for the matchdays list.
class MatchDayTile extends StatelessWidget {

  /// This widget is used to create a list tile for the matchdays list.
  MatchDayTile(
    {
      super.key, 
      required this.matchday
    }
  );

  Map<String, dynamic> matchday;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
            style: BorderStyle.solid
          )
        )
      ),
      child: ListTile(
        title: Text(
          'Matchday ${matchday["number"]}',
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          formatDateIntoWords(matchday["date"]),
          style: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "edit",
                child: RegularText(text: "Edit"),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case "edit":
                break;
              default:
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Matches(matchday: matchday)),
          );
        },
      )
    );
  }
}

/// This widget is used to create a list tile for the standings list.
class StandingsTile extends StatefulWidget {

  /// This widget is used to create a list tile for the standings list.
  StandingsTile(
    {
      super.key, 
      required this.standings,
    }
  );

  Map<String, dynamic> standings;

  @override
  StandingsTileState createState() => StandingsTileState();

}

/// This widget is used to create a list tile for the standings list.
class StandingsTileState extends State<StandingsTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: Text(
          "${widget.standings['competition']['name']} ${widget.standings['name']} (${widget.standings['competition']['gender']})",
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "delete",
                child: RegularText(text: "Delete"),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case "delete":
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return ConfirmDialogBox(
                      title: "Delete Standings",
                      message: "Are you sure you want to delete this standings?",
                      onOk: () async {
                        Map <String, dynamic> response = await deleteStandings(widget.standings['id']);

                        if (!mounted) return;

                        if (response['status']) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return MessageDialogBox(
                                message: response['message'],
                                title: 'Success', 
                                onOk: () {
                                }
                              );
                            }
                          );
                        }

                        else {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return MessageDialogBox(
                                message: response['message'],
                                title: 'Error', 
                                onOk: () {
                                }
                              );
                            }
                          );
                        }
                      },
                    );
                  }
                );
              default:
            }
          },
        ),
        onTap: () {
          
        }
      )
    );
  }
}


/// This is used to display fixtures in the Fixtures page.
class Fixture extends StatelessWidget{

  /// This is used to display fixtures in the Fixtures page.
  const Fixture(
    {
      super.key,
      required this.fixture
    }
  );

  final Map<String,dynamic> fixture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Match(
              match: fixture
            )
          )
        );
      },
      child: Center(

        child: Column(
          children:[

            const SizedBox(height: 15),

            Text(
              "${fixture['competition']['name']} (${fixture['competition']['gender']})",
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500
              )
            ),

            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.2,
                    style: BorderStyle.solid
                  )
                )
              ),
              height: 70,

              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    fixture['home_team']['logo_url'],
                    width: MediaQuery.of(context).size.width*0.2,
                    height: 40,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Icon(Icons.error, color: Colors.white,);
                    }
                  ),
                  

                  Text(
                    fixture['home_team']['name_abbreviation'],
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.2,
                        style: BorderStyle.solid
                      )
                    ),
                    child: Text(
                      fixture['match_time'].substring(0, 5),
                      style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 197, 50, 50),
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    
                  ),

                  Text(
                    fixture['away_team']['name_abbreviation'],
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  

                  Image.network(
                    fixture['away_team']['logo_url'],
                    width: MediaQuery.of(context).size.width*0.2,
                    height: 40,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Icon(Icons.error, color: Colors.white,);
                    }
                  ),
                  
                ],
              )
            ),

          ]

        

        )

      )
    );
  }

}

/// This is used to display results in the Results page.
class Result extends StatelessWidget{

  /// This is used to display results in the Results page.
  const Result(
    {
      super.key,
      required this.result
    }
  );


  final Map<String,dynamic> result;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          children:[

            const SizedBox(height: 15),

            Text(
              "${result['competition']['name']} (${result['competition']['gender']})",
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500
              )
            ),


            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.2,
                    style: BorderStyle.solid
                  )
                )
              ),
              height: 100,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRect(
                    child: Image.network(
                      result['home_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                  ),

                  Text(
                    result['home_team']['name_abbreviation'],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: result['home_team_score'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 15, // Set the font size for '2'
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '   FT   ',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: result['away_team_score'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 15, // Set the font size for '1'
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Text(
                    result['away_team']['name_abbreviation'],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  

                  ClipRect(
                    child: Image.network(
                      result['away_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                  )
                ],
              )
            )
          ]
        )

      ),
      onTap: () {
       
      },
    );
  }

}

/// This displays a news item in the News page. It contains the news title, image, and tag.
class NewsTile extends StatelessWidget{

  const NewsTile(
    {
      super.key,
      required this.news
    }
  );

  final Map<String,dynamic> news;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:GestureDetector(
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ViewNews(news: news)
            )
          );
        },
        child: Container(
          height: 110,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Row(
            children: [
              Image.network(
                news['featured_image'],
                width: 100,
                height:110,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Icon(Icons.error, color: Colors.white,);
                }
              ),
              

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        news['title'],
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      const SizedBox(height: 7.5,),

                      // aligns the date to the left
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${formatDateIntoWords(news['pub_date'])} - ${news['tag']['name']}",
                          style: GoogleFonts.poppins(
                            color:  Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                )
              )
            ],
          )
        )
      )
    );
  }

}

/// This displays the entire news item in the ViewNews page. It contains the news title, image, tag, content, date published and author.
class NewsItem extends StatelessWidget {

  const NewsItem(
    {
      super.key,
      required this.news
    }
  );

  final Map<String,dynamic> news;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.network(
          news['featured_image'],
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            news['title'],
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "${news['tag']['name']} | ${formatDateIntoWords(news['pub_date'])}",
            style: GoogleFonts.roboto(
              fontSize: 12,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "By ${news['author']['first_name']} ${news['author']['last_name']}",
            style: GoogleFonts.roboto(
              fontSize: 12,
            ),
          ),
        ),



        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            news['text'],
            style: GoogleFonts.roboto(
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}



class ListViewHeading extends StatelessWidget {

  const ListViewHeading({
    super.key,
    required this.heading,
    required this.buttonText,
    required this.onPressed,
  });

  final String heading;
  final String buttonText;
  final Function () onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LeftAlignedText(
            text: HeaderText(
              text: heading, 
              fontSize: 16, 
              fontWeight: FontWeight.w700 ,)
          ),

          AddButton(
            onPressed: onPressed,
            text: buttonText,
          ),
        ],

      ),
    );
  }

}

/// This displays the standings for a competition
class StandingsTable extends StatelessWidget {

  const StandingsTable(
    {
      super.key,
      required this.standingsTeams,
    }
  );

  final List<dynamic> standingsTeams;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: MediaQuery.of(context).size.width*0.06,
          dividerThickness: 0.3,
          columns: const <DataColumn>[

            // pos
            DataColumn(
              label: HeaderText(
                text: 'Pos',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // name
            DataColumn(
              label: HeaderText(
                text: 'Club',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // played
            DataColumn(
              label: HeaderText(
                text: 'PL',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // wins
            DataColumn(
              label: HeaderText(
                text: 'W',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // draws      
            DataColumn(
              label: HeaderText(
                text: 'D',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // losses      
            DataColumn(
              label: HeaderText(
                text: 'L',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // goal scored      
            DataColumn(
              label: HeaderText(
                text: 'GS',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // goal conceded      
            DataColumn(
              label: HeaderText(
                text: 'GC',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

            // goal difference

            DataColumn(
              label: HeaderText(
                text: 'GD',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),


            // points      
            DataColumn(
              label: HeaderText(
                text: 'PTS',
                color: Color.fromARGB(255, 53, 52, 52),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          rows: standingsTeams.map((standingsTeam) => DataRow(
              cells: [

                // pos
                DataCell(
                  HeaderText(
                    // index + 1 because index starts at 0
                    text: (standingsTeams.indexOf(standingsTeam) + 1).toString(),
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // name
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      Image.network(
                        standingsTeam['team']['logo_url'],
                        width: 20,
                        height: 20,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.error, color: Colors.white,);
                        }
                      ),

                      const Text("  "),
                      HeaderText(
                        text: standingsTeam['team']['name_abbreviation'],
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ]

                  )
                ),

                // no_played
                DataCell(
                  HeaderText(
                    text:standingsTeam['matches_played'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),


                // goals
                DataCell(
                  HeaderText(
                    text: standingsTeam['matches_won'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['matches_drawn'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['matches_lost'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['goals_for'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['goals_against'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['goal_difference'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                DataCell(
                  HeaderText(
                    text: standingsTeam['points'].toString(),
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ).toList(),
        )
      )
    );
  }
  
}
