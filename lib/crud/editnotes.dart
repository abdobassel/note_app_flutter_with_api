import 'package:flutter/material.dart';
import 'package:notes_flutter/endpoints.dart';
import 'package:notes_flutter/main.dart';
import 'package:notes_flutter/toast.dart';

class EditNotes extends StatefulWidget {
  const EditNotes(
      {super.key,
      required this.titleNote,
      required this.bodyNote,
      required this.noteId});
  final String titleNote;
  final String bodyNote;
  final String noteId;
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  Crud crud = Crud();
  bool isLoading = false;

  updateNote() async {
    setState(() {
      isLoading = true;
    });
    if (form.currentState!.validate()) {
      var respo = await crud.postRequest(UPDATE_NOTE, {
        'title': title.text,
        'body': body.text,
        'note_id': widget.noteId.toString(),
      });

      if (respo != null && respo['status'] != null && respo['status']) {
        print('Success');
        ShowToast(text: 'Updated Note', state: ToastStates.SUCCESS);
        Navigator.of(context).pushNamed("homepage");
      } else {
        print('Failed Update');
        ShowToast(
            text: 'Failed Update Note Or No changes', state: ToastStates.ERROR);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    title.text = widget.titleNote;
    body.text = widget.bodyNote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Column(
        children: [
          Form(
            key: form,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 30,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Title",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.note),
                  ),
                ),
                TextFormField(
                  controller: body,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Body of note cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 300,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Note Here",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.note),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await updateNote();
                  },
                  child:
                      isLoading ? CircularProgressIndicator() : Text("Update"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
