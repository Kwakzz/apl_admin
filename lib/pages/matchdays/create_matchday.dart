import 'package:apl_admin/util/validate.dart';
import 'package:apl_admin/widgets/app_bar.dart';
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/form.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMatchDay extends StatefulWidget {

  const CreateMatchDay({
    super.key,
    required this.season
  });

  final Map<String, dynamic> season;

  @override
  CreateMatchDayState createState() => CreateMatchDayState();

}

class CreateMatchDayState extends State<CreateMatchDay> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matchDayNumberController = TextEditingController();
  final TextEditingController _matchDayDateController = TextEditingController();
  DateTime? _matchDayDate;


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
  void dispose() {
    _matchDayNumberController.dispose();
    _matchDayDateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBarWithNoPrevButton(
        title: "Create Match Day (${widget.season['name']})",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              AppFormField(
                controller: _matchDayNumberController,
                hintText: "e.g. Enter 1 for Match Day 1",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a match day number";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid match day number";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _matchDayDateController,
                hintText: "Match day date",
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context, _matchDayDate, _matchDayDateController);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a match day date";
                  }
                  if (!validateDate(value)) {
                    return "Please enter a valid match day date";
                  }
                  return null;
                },
              ),


              SubmitFormButton(
                text: "Create Matchday",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    Map<String, dynamic> response = await createMatchday(          
                      widget.season['id'], 
                      _matchDayDateController.text,
                      int.tryParse(_matchDayNumberController.text)!
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

                }
              ),





            ],
          )
        ),
      ),
    );      
            
  }
}