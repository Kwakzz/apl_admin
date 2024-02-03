import 'dart:convert';

import 'package:apl_admin/helper/functions/validate.dart';
import 'package:apl_admin/helper/widgets/app_bar.dart';
import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/pages/home.dart';
import 'package:apl_admin/requests/season.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditSeason extends StatefulWidget {

  const EditSeason({
    super.key,
    required this.season
  });

  final Map<String, dynamic> season;

  @override
  EditSeasonState createState() => EditSeasonState();

}

class EditSeasonState extends State<EditSeason> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;


  /// This function shows a date picker when the user taps on the date of birth field.
  /// It updates the field with the selected date.
  Future<void> _selectDate(BuildContext context, DateTime? date, TextEditingController dateController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
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
  void initState() {
    super.initState();

    _seasonNameController.text = widget.season['name'];
    _startDateController.text = widget.season['start_date'];
    _endDateController.text = widget.season['end_date'];

  }


  @override
  void dispose() {
    _seasonNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: const RegularAppBarNoBack(
        title: "Edit Season",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              AppFormField(
                controller: _seasonNameController,
                hintText: "e.g. Spring Season 2024",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a season name';
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _startDateController,
                hintText: "Date season starts",
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context, _startDate, _startDateController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start date';
                  }
                  if (!validateDate(value)) {
                    return "Please enter a valid start date";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _endDateController,
                hintText: "Date season ends",
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context, _endDate, _endDateController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end date';
                  }
                  if (!validateDate(value)) {
                    return "Please enter a valid end date";
                  }
                  return null;
                },
              ),

              SubmitFormButton(
                text: "Edit Season",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    String seasonJson = jsonEncode(<String, dynamic>{
                      'name': _seasonNameController.text,
                      'start_date': _startDateController.text,
                      'end_date': _endDateController.text
                    });

                    Map<String, dynamic> response = await updateSeason(
                      widget.season['id'].toString(),
                      seasonJson
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

                    }

                    else {
                        
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            title: "Error",
                            message: response['message'],
                            onOk: () {
                              setState(() {
                                widget.season['name'] = _seasonNameController.text; 
                                widget.season['start_date'] = _startDateController.text;
                                widget.season['end_date'] = _endDateController.text;
                              });
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