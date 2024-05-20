// ignore_for_file: must_be_immutable
import 'package:apl_admin/controllers/standings.dart';
import 'package:apl_admin/pages/news/view_news.dart';
import 'package:apl_admin/pages/standings/standings.dart';
import 'package:apl_admin/util/date_time.dart';
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/pages/home.dart';
import 'package:apl_admin/pages/matchdays/edit_matchday.dart';
import 'package:apl_admin/pages/matches/matches.dart';
import 'package:apl_admin/pages/players/edit_player.dart';
import 'package:apl_admin/pages/players/view_player.dart';
import 'package:apl_admin/pages/seasons/edit_season.dart';
import 'package:apl_admin/controllers/match_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DrawerTile extends StatelessWidget {

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPlayer(
                      player: player
                    )
                  ),
                );

              case "transfer":
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return CreateTransferDialogBox(
                      player: player
                    );
                  }
                );

              default: break;
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPlayer(
                player: player
              )
            ),
          );
        },
      )
    );
  }
}


class SeasonTile extends StatelessWidget {

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSeason(
                      season: season
                    )
                  ),
                );
              default:
            }
          },
        ),
        onTap: onTap
      )
    );
  }
}


class MatchDayTile extends StatelessWidget {

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditMatchDay(matchday: matchday)
                  ),
                );
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

class MatchEventTile extends StatefulWidget {

  MatchEventTile(
    {
      super.key, 
      required this.matchEvent,
    }
  );

  Map<String, dynamic> matchEvent;

  @override
  MatchEventTileState createState() => MatchEventTileState();

}

class MatchEventTileState extends State<MatchEventTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: Text(
          widget.matchEvent["event_type"],
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          "${widget.matchEvent['player']['first_name']} ${widget.matchEvent['player']['last_name']}",
          style: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        leading: Text(
          "${widget.matchEvent['minute']}'",
          style: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return ConfirmDialogBox(
                  title: "Delete Match Event",
                  message: "Are you sure you want to delete this match event?",
                  onOk: () async {
                    Map <String, dynamic> response = await deleteMatchEvent(widget.matchEvent['id']);

                    if (!mounted) return;

                    if (response['status']) {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            message: response['message'],
                            title: 'Success', 
                            onOk: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Home())
                              );
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
          },
        )

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewStandings(
                standings: widget.standings
              )
            ),
          );
        },
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Home())
                                  );
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
      )
    );
  }
}

class PlayerDetailsTile extends StatelessWidget {

  const PlayerDetailsTile(
    {
      super.key, 
      required this.playerDetail,
      required this.title,
      required this.team
    }
  );

  final String playerDetail;
  final String title;
  final Map<String,dynamic> team;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      color: Colors.white,
      child: ListTile(
        title: Text(
          title.toString().toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),          
        trailing: Text(
          playerDetail,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    );
  }

}


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