import 'package:apl_admin/util/validate.dart';
import 'package:apl_admin/widgets/app_bar.dart';
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/form.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateSeason extends StatefulWidget {

  const CreateSeason({
      super.key,
    });

  @override
  CreateSeasonState createState() => CreateSeasonState();

}

class CreateSeasonState extends State<CreateSeason> {

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
  void dispose() {
    _seasonNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: const AppBarWithNoPrevButton(
        title: "Create Season",
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
                text: "Create Season",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    Map<String, dynamic> response = await createSeason(
                      _seasonNameController.text,
                      _startDateController.text,
                      _endDateController.text
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