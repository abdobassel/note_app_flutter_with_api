import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_flutter/endpoints.dart';
import 'package:notes_flutter/main.dart';
import 'package:notes_flutter/toast.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  File? myfile;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  Crud crud = Crud();
  bool isLoading = false;
  bool uploadImage = false;
  addNote() async {
    if (form.currentState!.validate()) {
      var respo = await crud.postMultiRequest(
          ADD_NOTE,
          {
            'title': title.text,
            'body': body.text,
            'user_id': sharedPrefrence.get('id'),
          },
          myfile,
          'note_img');

      if (respo != null && respo['status'] != null && respo['status']) {
        print('Success');
        ShowToast(text: ' Added Note', state: ToastStates.SUCCESS);
        Navigator.of(context).pushNamed("homepage");
      } else {
        print('failed Add');
        ShowToast(text: 'Failed Adding Note', state: ToastStates.ERROR);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Column(
        children: [
          Form(
              key: form,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value!.isEmpty) {
                          return 'Title can not be empty';
                        }
                        return null;
                      }
                    },
                    controller: title,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Tilte",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.note)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'body of note can not be empty';
                        }
                        return null;
                      }
                    },
                    maxLength: 300,
                    maxLines: 4,
                    controller: body,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Note Here",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.note)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return ShowBottomChoose();
                    },
                    child: Text("Add img"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      await addNote();
                    },
                    child: Text("Add"),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  ShowBottomChoose() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Choose Image For Note', style: TextStyle(fontSize: 30)),
                  InkWell(
                    onTap: () async {
                      XFile? fileSource = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      myfile = File(fileSource!.path);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_album,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("From Gallery",
                                style: TextStyle(fontSize: 25)),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      XFile? fileSource = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      myfile = File(fileSource!.path);
                    },
                    child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "From Camera",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        )),
                  )
                ]),
          );
        });
  }
}
