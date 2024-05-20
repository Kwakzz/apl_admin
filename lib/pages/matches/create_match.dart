import 'package:apl_admin/util/validate.dart';
import 'package:apl_admin/widgets/app_bar.dart';
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/form.dart';
import 'package:apl_admin/controllers/referee.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:apl_admin/controllers/teams.dart';
import 'package:flutter/material.dart';

class CreateMatch extends StatefulWidget {

  const CreateMatch({
    super.key,
    required this.matchday
  });

  final Map<String, dynamic> matchday;

  @override
  CreateMatchState createState() => CreateMatchState();

}

class CreateMatchState extends State<CreateMatch> {

  final _formKey = GlobalKey<FormState>();

  int _selectedHomeTeamId = 0;
  int _selectedAwayTeamId = 0;
  int _selectedRefereeId = 0;
  int _selectedCompetitionId = 0;
  int _selectedStageId = 0;
  // ignore: prefer_final_fields
  TimeOfDay _selectedMatchTime = TimeOfDay.now();

  final TextEditingController _matchTimeController = TextEditingController();

  List<Map<String, dynamic>> referees = [];
  List<Map<String, dynamic>> teams = [];
  List<Map<String, dynamic>> competitions = [];
  List<Map<String, dynamic>> stages = [];


  // select time function 
  // use 24 hour format
  Future<void> _selectTime(BuildContext context, TimeOfDay time, TextEditingController timeController) async {

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != time) {
      setState(() {
        time = pickedTime;
        // set the time controller to the selected time in 24 hour format
        timeController.text =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
      });
    }

  }


  @override
  void dispose() {
    _matchTimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getReferees().then((value) {
      setState(() {
        referees = value;
      });
    });

    getCompetitions().then((value) {
      setState(() {
        competitions = value;
      });
    });

    getStages().then((value) {
      setState(() {
        stages = value;
      });
    });

    getTeams().then((value) {
      setState(() {
        teams = value;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBarWithNoPrevButton(
        title: "Create Match (Matchday ${widget.matchday['number'].toString()})",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              if (teams.isNotEmpty)
                AppDropDownButton(
                  items: teams.map((team) => "${team['name']}").toList(), 
                  onChanged: (value) {
                    setState(() {
                      _selectedHomeTeamId = teams.firstWhere((team) => team['name'] == value)['id'];
                    });
                  },
                  hintText: "Select a home team",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a home team';
                    }

                    Map<String, dynamic> selectedCompetition = competitions.firstWhere((competition) => competition['id'] == _selectedCompetitionId);
                    if (selectedCompetition['gender'] == 'W' && !teams.firstWhere((team) => team['name'] == value)['has_womens_team']) {
                      return 'Only women\'s teams can participate in the selected competition';
                    }

                    return null;
                  },
                ),

              if (teams.isNotEmpty)
                AppDropDownButton(
                  items: teams.map((team) => "${team['name']}").toList(), 
                  onChanged: (value) {
                    setState(() {
                      _selectedAwayTeamId = teams.firstWhere((team) => team['name'] == value)['id'];
                    });
                  },
                  hintText: "Select an away team",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a home team';
                    }

                    if (_selectedHomeTeamId == _selectedAwayTeamId) {
                      return 'Home and away teams must differ';
                    }

                    Map<String, dynamic> selectedCompetition = competitions.firstWhere((competition) => competition['id'] == _selectedCompetitionId);
                    if (selectedCompetition['gender'] == 'W' && !teams.firstWhere((team) => team['name'] == value)['has_womens_team']) {
                      return 'Only women\'s teams can participate in the selected competition';
                    }
                  
                    return null;
                  },
                ),

              if (competitions.isNotEmpty)
                AppDropDownButton(
                  items: competitions.map((competition) => "${competition['name']}-${competition['gender']}").toList(), 
                  onChanged: (value) {
                    setState(() {
                      _selectedCompetitionId = competitions.firstWhere((competition) => competition['name'] == value!.split('-')[0] && competition['gender']==value.split('-')[1])['id'];
                    });
                  },
                  hintText: "Select a competition",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a competition';
                    }
                  
                    return null;
                  },
                ),

              if (stages.isNotEmpty)
                AppDropDownButton(
                  hintText: 'Select stage. Leave blank or select none if it\'s a league match',
                  items: [...stages.map((stage) => stage['name']), 'None'],
                  onChanged: (value) {
                    setState(() {
                      if (value == 'None') {
                        _selectedStageId = 0;
                        return;
                      }
                      _selectedStageId = stages.firstWhere((stage) => stage['name'] == value)['id'];
                    });
                  },
                  validator: (value) {
                    Map<String, dynamic> selectedCompetition = competitions.firstWhere((competition) => competition['id'] == _selectedCompetitionId);

                    if (selectedCompetition['name'] == 'Premier League' && _selectedStageId != 0) {
                      return 'Premier League matches don\'t have stages';
                    }
                  
                    return null;
                  },
                ),

              AppFormField(
                controller: _matchTimeController,
                hintText: 'Select the match time',
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectTime(context, _selectedMatchTime, _matchTimeController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a match time';
                  }
                  // check if the match time is in the correct format
                  if (!validateTime(value)) {
                    return 'Please select a valid match time';
                  }
                  
                 
                  return null;
                },
              ),  

              if (referees.isNotEmpty)
                AppDropDownButton(
                  items: referees.map((referee) => "${referee['first_name']} ${referee['last_name']}").toList(), 
                  onChanged: (value) {
                    setState(() {
                      _selectedRefereeId = referees.firstWhere((referee) => "${referee['first_name']} ${referee['last_name']}" == value)['id'];
                    });
                  },
                  hintText: "Select a referee",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a referee';
                    }
                    return null;
                  },
                ),         

              SubmitFormButton(
                text: "Create Match",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {


                    Map<String, dynamic> response = {};

                    if (_selectedStageId == 0) {
                      response = await createMatchWithoutStage(
                        widget.matchday['id'], 
                        _selectedRefereeId, 
                        _matchTimeController.text, 
                        _selectedHomeTeamId, 
                        _selectedAwayTeamId, 
                        _selectedCompetitionId,
                      );
                    }

                    else {
                      response = await createMatchWithStage(
                        widget.matchday['id'], 
                        _selectedRefereeId, 
                        _matchTimeController.text, 
                        _selectedHomeTeamId, 
                        _selectedAwayTeamId, 
                        _selectedCompetitionId,
                        _selectedStageId
                      );
                    }

                    if (!mounted) return;

                    if (response['status']) {

                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            title: "Success",
                            message: response['message'],
                            onOk: () {
                            },
                          );
                        }
                      );

                    }

                    else {
                        
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            title: "Error",
                            message: response['message'],
                            onOk: () {
                            },
                          );
                        }
                      );
                      
                    }

                  }

                }
              ),

            ],
          )
        ),
      ),
    );      
            
  }
}