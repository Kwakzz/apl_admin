import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/helper/widgets/text.dart';
import 'package:apl_admin/requests/season.dart';
import 'package:apl_admin/requests/teams.dart';
import 'package:flutter/material.dart';

import 'view_match_events.dart';

class Match extends StatefulWidget {

  const Match({
    super.key,
    required this.match,
  });

  final Map<String, dynamic> match;

  @override
  MatchState createState() => MatchState();

}

class MatchState extends State<Match> {

  List<Map<String, dynamic>> _homePlayers = [];
  List<Map<String, dynamic>> _awayPlayers = [];
  TextEditingController _minuteController = TextEditingController();



  @override
  void initState() {
    super.initState();

    if (widget.match['competition']['gender'] =='W') {
      getWomensPlayersInTeam(widget.match['home_team']['id']).then((List<Map<String, dynamic>> players) {
        setState(() {
          _homePlayers = players;
        });
      });
      getWomensPlayersInTeam(widget.match['away_team']['id']).then((List<Map<String, dynamic>> players) {
        setState(() {
          _awayPlayers = players;
        });
      });
    }
    else {
      getMensPlayersInTeam(widget.match['home_team']['id']).then((List<Map<String, dynamic>> players) {
        setState(() {
          _homePlayers = players;
        });
      });
      getMensPlayersInTeam(widget.match['away_team']['id']).then((List<Map<String, dynamic>> players) {
        setState(() {
          _awayPlayers = players;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    if (!widget.match['has_started']) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ListView(
            children: [

              Fixture(
                fixture: widget.match
              ),

              const SizedBox(height: 20),

              Center(
                child: SubmitFormButton(
                  text: 'Start Match',
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return ConfirmDialogBox(
                          message: 'Are you sure you want to start this match?',
                          title: 'Start Match', 
                          onOk: () async {
                            
                            Map<String, dynamic> response = await startMatch(widget.match['id']);
                            if (response['status']) {
                              // reload the page
                              setState(() {
                                widget.match['has_started'] = true;
                              });
                            }
                            else {
                              
                              
                            }
                          }
                        );
                      }
                    );
                  }
                ),
              ),
              
            ],
          ),
        ),
      );
    }

    if (!widget.match['has_ended'] && widget.match['has_started']) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ListView(
            children: [

              Result(
                result: widget.match
              ),

              const SizedBox(height: 20),

              CenteredText(
                text: LinkText(
                  text: const SubHeaderText(
                    text:'View Match Events',
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ViewMatchEvents(
                          matchId: widget.match['id'],
                        )
                      )
                    );
                  }
                )
              ),

              const SizedBox(height: 20),

              // Add Goal
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubmitFormButton(
                      text: "Add ${widget.match['home_team']['name_abbreviation']} Goal",
                      
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return GoalDialogBox(
                              players: _homePlayers,
                              match: widget.match,
                              minuteController: _minuteController,
                              scoringTeam: widget.match['home_team'],
                            );
                          }
                        );
                      }
                    ),

                    SubmitFormButton(
                      text: "Add ${widget.match['away_team']['name_abbreviation']} Goal",
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return GoalDialogBox(
                              players: _awayPlayers,
                              match: widget.match,
                              scoringTeam: widget.match['away_team'],
                              minuteController: _minuteController,
                            );
                          }
                        );
                      }
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Add Booking
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubmitFormButton(
                      text: "Add ${widget.match['home_team']['name_abbreviation']} Booking",
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return BookingDialogBox(
                              players: _homePlayers,
                              match: widget.match,
                              minuteController: _minuteController,
                              team: widget.match['home_team'],
                            );
                          }
                        );
                      }
                    ),

                    SubmitFormButton(
                      text: "Add ${widget.match['away_team']['name_abbreviation']} Booking",
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return BookingDialogBox(
                              players: _awayPlayers,
                              match: widget.match,
                              minuteController: _minuteController,
                              team: widget.match['away_team'],
                            );
                          }
                        );
                      }
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 20,),
              

              Center(
                child: SubmitFormButton(
                  text: 'End Match',
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return ConfirmDialogBox(
                          message: 'Are you sure you want to end this match?',
                          title: 'End Match', 
                          onOk: () async {
                            
                            Map<String,dynamic> response = await endMatch(widget.match['id']);

                            if (!mounted) return;

                            if (response['status']) {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return MessageDialogBox(
                                    message: response['message'],
                                    title: 'Success', 
                                    onOk: () {
                                      setState(() {
                                        widget.match['has_ended'] = true;
                                      });
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
                          }
                        );
                      }
                    );
                  }
                )
              ),
              
            ],
          ),
        ),
      );
    }
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [

            Result(
              result: widget.match
            ),

            const SizedBox(height: 20),

            Center(
              child: SubmitFormButton(
                text: 'Restart Match',
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return ConfirmDialogBox(
                        message: 'Are you sure you want to restart this match?',
                        title: 'Restart Match', 
                        onOk: () async {
                          
                          Map<String,dynamic> response = await restartMatch(widget.match['id']);

                          if (!mounted) return;

                          if (response['status']) {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return MessageDialogBox(
                                  message: response['message'],
                                  title: 'Success', 
                                  onOk: () {
                                    Navigator.pop(context);
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
                        }
                      );
                    }
                  );
                }
              )
            ),
        
          ],
    
        ),
      ),
    );
    
  }
}

