// ignore_for_file: must_be_immutable

import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/requests/goals.dart';
import 'package:apl_admin/requests/match_event.dart';
import 'package:apl_admin/requests/players.dart';
import 'package:apl_admin/requests/standings.dart';
import 'package:apl_admin/requests/teams.dart';
import 'package:flutter/material.dart';

import 'text.dart';


/// This dialog box is used to display a message. It is usually used to display a success or error message.
class MessageDialogBox extends StatelessWidget {

  final String message;
  final String title;
  final Function onOk;

  const MessageDialogBox(
    {
      super.key, 
      required this.message,
      required this.title,
      required this.onOk,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: HeaderText(
        text: title
      ),
      content: RegularText(
        text: message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            onOk();
          },
          child: RegularText(
            text: "OK",
          ),
        ),
      ],
    );
  }
}

/// This dialog box asks for confirmation from the user. It is can be used to confirm a delete action.
class ConfirmDialogBox extends StatelessWidget {

  final String message;
  final String title;
  final Function onOk;

  const ConfirmDialogBox(
    {
      super.key, 
      required this.message,
      required this.title,
      required this.onOk,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: HeaderText(
        text: title
      ),
      content: RegularText(
        text: message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onOk();
          },
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}


/// This dialog box contains a form for creating a goal.
class GoalDialogBox extends StatefulWidget {

  final List<Map<String, dynamic>> players;
  final Map<String, dynamic> match;
  final Map<String, dynamic> scoringTeam;
  int selectedScorerId;
  int selectedAssisterId;
  TextEditingController minuteController;

  GoalDialogBox(
    {
      super.key, 
      required this.players,
      required this.match,
      required this.scoringTeam,
      this.selectedScorerId = 0,
      this.selectedAssisterId = 0,
      required this.minuteController,
    }
  );

  @override
  GoalDialogBoxState createState() => GoalDialogBoxState();
}

class GoalDialogBoxState extends State <GoalDialogBox> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const HeaderText(
        text: "Add a goal",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDropDownButton(
              items: widget.players.map((player) => "${player['first_name']} ${player['last_name']}").toList(),
              hintText: "Scorer",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the scorer\'s name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.selectedScorerId = widget.players.firstWhere((player) => "${player['first_name']} ${player['last_name']}" == value)['id'];
                });
              },
            ),

            AppDropDownButton(
              items: [...widget.players.map((player) => "${player['first_name']} ${player['last_name']}"),'None'],
              hintText: "Select an assister. Don't select if there is no assister.",
              validator: (value) {
                // check if the assister is the same as the scorer
                if (value == "${widget.players.firstWhere((player) => player['id'] == widget.selectedScorerId)['first_name']} ${widget.players.firstWhere((player) => player['id'] == widget.selectedScorerId)['last_name']}") {
                  return 'The assister cannot be the same as the scorer';
                }
                return null;
              },
              onChanged: (value) {
                if (value == 'None') {
                  setState(() {
                    widget.selectedAssisterId = 0;
                  });
                }
                else {
                  setState(() {
                    widget.selectedAssisterId = widget.players.firstWhere((player) => "${player['first_name']} ${player['last_name']}" == value)['id'];
                  });
                }
              },
            ),

            AppFormField(
              hintText: "Minute",
              controller: widget.minuteController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the minute the goal was scored';
                }
                if (int.parse(value) < 0 || int.parse(value) > 120) {
                  return 'Please enter a valid minute';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid minute';
                }
                return null;
              },
            ),
            
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {

            if (_formKey.currentState!.validate()) {

              

              Map<String, dynamic> response;
        
              if (widget.selectedAssisterId == 0) {
                response = await createGoalWithoutAssist(
                  widget.match['id'],
                  widget.scoringTeam['id'], 
                  widget.selectedScorerId, 
                  int.parse(widget.minuteController.text)
                );
              }

              else {
                response = await createGoalWithAssist(
                  widget.match['id'], 
                  widget.scoringTeam['id'], 
                  widget.selectedScorerId, 
                  widget.selectedAssisterId, 
                  int.parse(widget.minuteController.text)
                );
              }

              if (!mounted) return; 

              if (response['status']) {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return MessageDialogBox(
                      message: response['message'],
                      title: 'Success', 
                      onOk: () {
                        Navigator.of(context).pop();
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
                        Navigator.of(context).pop();
                      }
                    );
                  }
                );
              }
            }
          },
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}


/// This dialog box contains a form for creating a goal.
class BookingDialogBox extends StatefulWidget {

  final List<Map<String, dynamic>> players;
  final Map<String, dynamic> match;
  int selectedPlayerId;
  TextEditingController minuteController;
  String selectedCardType;
  final Map<String, dynamic> team;

  BookingDialogBox(
    {
      super.key, 
      required this.players,
      required this.team,
      required this.match,
      this.selectedPlayerId = 0,
      required this.minuteController,
      this.selectedCardType = "",
    }
  );

  @override
  BookingDialogBoxState createState() => BookingDialogBoxState();
}

class BookingDialogBoxState extends State <BookingDialogBox> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const HeaderText(
        text: "Add a booking",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            AppDropDownButton(
              hintText: "Card Type",
              items: const [
                "Yellow Card",
                "Red Card"
              ], 
              onChanged: (value) {
                setState(() {
                  widget.selectedCardType = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please pick a card type';
                }
                return null;
              },
            ),

            AppDropDownButton(
              items: widget.players.map((player) => "${player['first_name']} ${player['last_name']}").toList(),
              hintText: "The player who was booked",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select the player who was booked';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.selectedPlayerId = widget.players.firstWhere((player) => "${player['first_name']} ${player['last_name']}" == value)['id'];
                });
              },
            ),

            AppFormField(
              hintText: "Minute the foul was committed in",
              controller: widget.minuteController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the minute the foul was committed';
                }
                if (int.parse(value) < 0 || int.parse(value) > 120) {
                  return 'Please enter a valid minute';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid minute';
                }
                return null;
              },
            ),
            
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {

            if (_formKey.currentState!.validate()) {

              Map<String, dynamic> response = await createBooking(
                widget.match['id'], 
                widget.selectedPlayerId, 
                widget.team['id'],
                int.parse(widget.minuteController.text),
                widget.selectedCardType
              );

              if (!mounted) return; 

              if (response['status']) {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return MessageDialogBox(
                      message: response['message'],
                      title: 'Success', 
                      onOk: () {
                        Navigator.of(context).pop();
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
                        Navigator.of(context).pop();
                      }
                    );
                  }
                );
              }
            }
          },
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}



/// This dialog box contains a form for creating a goal.
class AddStandingsDialogBox extends StatefulWidget {

  final List<Map<String, dynamic>> seasons;
  int selectedSeasonId;
  String selectedCompetition;

  AddStandingsDialogBox(
    {
      super.key, 
      required this.seasons,
      this.selectedSeasonId = 0,
      this.selectedCompetition = "",
    }
  );

  @override
  AddStandingsDialogBoxState createState() => AddStandingsDialogBoxState();
}

class AddStandingsDialogBoxState extends State <AddStandingsDialogBox> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const HeaderText(
        text: "Create table",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            AppDropDownButton(
              items: widget.seasons.map((season) => "${season['name']}").toList(),
              hintText: "Select a season",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a season';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.selectedSeasonId = widget.seasons.firstWhere((season) => "${season['name']}" == value)['id'];
                });
              },
            ),

            AppDropDownButton(
              items: const [
                'Men\'s FA Cup',
                'Men\'s Premier League',
                'Women\'s Premier League',
              ],
              hintText: "Which competition is this table for?",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a competition';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.selectedCompetition = value!;
                });
              },
            ),

            

            
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {

            if (_formKey.currentState!.validate()) {

              Map<String, dynamic> response = {};

              if (widget.selectedCompetition == "Men's Premier League") {
                response = await createMensLeagueStandings(
                  widget.selectedSeasonId
                );
              }

              if (widget.selectedCompetition == "Men's FA Cup") {
                response = await createMensFACupStandings(
                  widget.selectedSeasonId
                );
              }

              if (widget.selectedCompetition == "Women's Premier League") {
                response = await createWomensLeagueStandings(
                  widget.selectedSeasonId
                );
              }
 
              if (!mounted) return; 

              if (response['status']) {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return MessageDialogBox(
                      message: response['message'],
                      title: 'Success', 
                      onOk: () {
                        Navigator.of(context).pop();
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
                        Navigator.of(context).pop();
                      }
                    );
                  }
                );
              }
            }
          },
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}



/// This dialog box contains a form for creating a goal.
class TransfersDialogBox extends StatefulWidget {

  final Map<String, dynamic> player;
  int selectedTeamId;
  List<Map<String, dynamic>> teams;

  TransfersDialogBox(
    {
      super.key, 
      required this.player,
      this.selectedTeamId = 0,
      this.teams = const [],
    }
  );

  @override
  TransfersDialogBoxState createState() => TransfersDialogBoxState();
}

class TransfersDialogBoxState extends State <TransfersDialogBox> {

  @override
  void initState() {
    super.initState();
    getTeams().then((teams) {
      setState(() {
        widget.teams = teams;
      });
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const HeaderText(
        text: "Transfer",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            if (widget.teams.isNotEmpty)
              AppDropDownButton(
                items: widget.teams
                  .where((team) => team['name'] != widget.player['team']['name'])
                  .map((team) => "${team['name']}")
                  .toList(),
                hintText: "Which team is the player moving to?",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a team';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    widget.selectedTeamId = widget.teams.firstWhere((team) => "${team['name']}" == value)['id'];
                  });
                },
              ),
            
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {

            if (_formKey.currentState!.validate()) {

              Map<String, dynamic> response = await transferPlayer(
                widget.selectedTeamId,
                widget.player['id']
              );
 
              if (!mounted) return; 

              if (response['status']) {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return MessageDialogBox(
                      message: response['message'],
                      title: 'Success', 
                      onOk: () {
                        Navigator.of(context).pop();
                        setState(() {
                          
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
                        Navigator.of(context).pop();
                      }
                    );
                  }
                );
              }
            }
          },
          child: RegularText(
            text: "OK",
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: RegularText(
            text: "Cancel",
          ),
        ),
      ],
    );
  }
}



