import 'package:apl_admin/helper/widgets/app_bar.dart';
import 'package:apl_admin/helper/widgets/dialog_box.dart';
import 'package:apl_admin/helper/widgets/form.dart';
import 'package:apl_admin/requests/news.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';


class CreateNewsItem extends StatefulWidget {

  const CreateNewsItem({
      super.key,
    });

  @override
  CreateNewsItemState createState() => CreateNewsItemState();

}

class CreateNewsItemState extends State<CreateNewsItem> {

  final _formKey = GlobalKey<FormState>();


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  int _selectedTagId = 0;

  List<Map<String, dynamic>> tags = [];


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
    _titleController.dispose();
    _subtitleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getTags().then((value) {
      setState(() {
        tags = value;
      });
    }); 

  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: const RegularAppBarNoBack(
        title: "Create News Item",
      ),

      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Form(
          key: _formKey,
          child: ListView(
            children: [

              UploadImageButton(
                text: "Upload Featured Image",
                onPressed: _pickImage,
              ),

              if (_selectedImageBytes != null)
                Image.memory(_selectedImageBytes!, height: 200),

              

              AppFormField(
                controller: _titleController,
                hintText: "Title",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _subtitleController,
                hintText: "Subtitle",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a last name";
                  }
                  return null;
                },
              ),

              AppFormField(
                controller: _textController,
                hintText: "Type the content here",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the news content";
                  }
                  return null;
                },
              ),

              if (tags.isNotEmpty)
                AppDropDownButton(
                  items: tags.map((tag) => "${tag['name']}").toList(),
                  hintText: "Select tag",
                  onChanged: (value) {
                    setState(() {
                      _selectedTagId = tags.firstWhere((tag) => tag['name'] == value)['id'];
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a tag';
                    }
                    return null;
                  },
                ),

              SubmitFormButton(
                text: "Create News Item",
                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    if (_selectedImageBytes == null) {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return MessageDialogBox(
                            title: "Error",
                            message: "Please upload a featured image",
                            onOk: () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      );
                    }

                    Map<String, dynamic> response = await createNewsItem(
                      _titleController.text,
                      _subtitleController.text,
                      _textController.text,
                      _selectedTagId,
                      _selectedImageBytes,
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