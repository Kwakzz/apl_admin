import 'dart:typed_data';

import 'package:apl_admin/helper/functions/string.dart';
import 'package:apl_admin/helper/widgets/app_bar.dart';
import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/requests/players.dart';
import 'package:apl_admin/requests/teams.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreatePlayer extends StatefulWidget {

  const CreatePlayer({
      super.key,
    });

  @override
  CreatePlayerState createState() => CreatePlayerState();

}

class CreatePlayerState extends State<CreatePlayer> {

  final _formKey = GlobalKey<FormState>();

  int _selectedPositionId = 0;
  int _selectedTeamId = 0;
  String _selectedGender = 'M';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  String _selectedMajor= '';

  List<Map<String, dynamic>> positions = [];
  List<Map<String, dynamic>> teams = [];

  Uint8List? _selectedImageBytes;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _selectedImageBytes = result.files.single.bytes;
      });
    }
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _yearGroupController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getPositions().then((value) {
      setState(() {
        positions = value;
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
      appBar: const RegularAppBarNoBack(
        title: "Create Player",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              UploadImageButton(
                text: "Upload Player Image",
                onPressed: _pickImage,
              ),

              if (_selectedImageBytes != null)
                Image.memory(_selectedImageBytes!, height: 200),

              AppFormField(
                controller: _firstNameController,
                hintText: "First Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a first name";
                  }
                  // check if name contains only alphabets
                  if (!hasOnlyAlphabets(value)) {
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
                  if (!hasOnlyAlphabets(value)) {
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

              AppDropDownButton(
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

              if (teams.isNotEmpty)
                AppDropDownButton(
                  items: teams.map((team) => "${team['name']}").toList(),
                  hintText: "Select Team",
                  onChanged: (value) {
                    setState(() {
                      _selectedTeamId = teams.firstWhere((team) => team['name'] == value)['id'];
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a team';
                    }
                    return null;
                  },
                ),

              if (positions.isNotEmpty)
                AppDropDownButton(
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

              AppDropDownButton(
                hintText: "Gender",
                items: const ['M', 'W'], 
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a gender';
                    }
                    return null;
                }
              ),

              SubmitFormButton(
                text: "Create Player",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    Map<String, dynamic> response = {};

                    if (_selectedImageBytes == null) {
                      response = await createPlayerWithoutImage(
                        _firstNameController.text,
                        _lastNameController.text,
                        _yearGroupController.text,
                        _selectedMajor,
                        _selectedGender,
                        _selectedTeamId,
                        _selectedPositionId
                      );
                    }

                    else {
                      response = await createPlayerWithImage(
                        _firstNameController.text,
                        _lastNameController.text,
                        _yearGroupController.text,
                        _selectedMajor,
                        _selectedGender,
                        _selectedTeamId,
                        _selectedPositionId,
                        _selectedImageBytes,
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