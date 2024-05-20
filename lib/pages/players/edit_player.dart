import 'dart:convert';
import 'package:apl_admin/util/string.dart';
import 'package:apl_admin/util/validate.dart';
import 'package:apl_admin/widgets/app_bar.dart';
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/form.dart';
import 'package:apl_admin/pages/home.dart';
import 'package:apl_admin/controllers/players.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPlayer extends StatefulWidget {

  const EditPlayer({
    super.key,
    required this.player
  });

  final Map<String, dynamic> player;

  @override
  EditPlayerState createState() => EditPlayerState();

}

class EditPlayerState extends State<EditPlayer> {

  final _formKey = GlobalKey<FormState>();

  int _selectedPositionId = 0;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  DateTime? _birthDate;
  String _selectedMajor= '';

  @override
  void initState() {
    super.initState();

    _selectedPositionId = widget.player['position']['id'];
    _firstNameController.text = widget.player['first_name'];
    _lastNameController.text = widget.player['last_name'];
    _yearGroupController.text = widget.player['year_group'].toString();
    _birthDateController.text = widget.player['birth_date'];
    _birthDate = DateTime.parse(widget.player['birth_date']);
    _selectedMajor = widget.player['major'];

    getPositions().then((value) {
      setState(() {
        positions = value;
      });
    });
    

  }

  

  List<Map<String, dynamic>> positions = [];
  List<Map<String, dynamic>> teams = [];

  /// This function shows a date picker when the user taps on the date of birth field.
  /// It updates the field with the selected date.
  Future<void> _selectDate(BuildContext context, DateTime? date, TextEditingController dateController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now().add(const Duration(days: 365))
    );
    
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _yearGroupController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: const AppBarWithNoPrevButton(
        title: "Edit Player",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              AppFormField(
                controller: _firstNameController,
                hintText: "First Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a first name";
                  }
                  // check if name contains only alphabets
                  if (!hasOnlyAlphabetsAndSpacesAndHyphens(value)) {
                    return "Please enter a valid first name";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _lastNameController,
                hintText: "Last Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a last name";
                  }
                  // check if name contains only alphabets
                  if (!hasOnlyAlphabetsAndSpacesAndHyphens(value)) {
                    return "Please enter a valid last name";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _yearGroupController,
                hintText: "Year Group",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a year group";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid year group";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _birthDateController,
                hintText: "Select Birth Date",
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context, _birthDate, _birthDateController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a birth date';
                  }
                  if (!validateDate(value)) {
                    return "Please enter a valid birth date";
                  }
                  return null;
                },
              ),

              AppDropDownButton(
                selectedValue: _selectedMajor,
                items: const ['CS', 'EE', 'ME', 'CE', 'BA', 'MIS'],
                hintText: "Select Major",
                onChanged: (value) {
                  setState(() {
                    _selectedMajor = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a major';
                  }
                  return null;
                },
              ),


              if (positions.isNotEmpty)
                AppDropDownButton(
                  selectedValue: positions.firstWhere((position) => position['id'] == _selectedPositionId)['name'],
                  items: positions.map((position) => "${position['name']}").toList(),
                  hintText: "Select Position",
                  onChanged: (value) {
                    setState(() {
                      _selectedPositionId = positions.firstWhere((position) => position['name'] == value)['id'];
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a position';
                    }
                    return null;
                  },
                  
                ),


              SubmitFormButton(
                text: "Edit Player",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    // jsonEncode player data
                    String playerJson = jsonEncode(<String, dynamic> {
                      'first_name': _firstNameController.text,
                      'last_name': _lastNameController.text,
                      'birth_date': _birthDateController.text,
                      'year_group': _yearGroupController.text,
                      'position': _selectedPositionId.toString(),
                      'major': _selectedMajor,
                    }); 

                    Map<String, dynamic> response = await updatePlayer(
                        widget.player['id'].toString(),
                        playerJson
                      );
                    

                    if (!mounted) return;

                    if (response['status']) {

                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            title: "Success",
                            message: response['message'],
                            onOk: () {
                              Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => const Home()
                                )
                              );
                            },
                          );
                        }
                      );

                      Navigator.pop(context);

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