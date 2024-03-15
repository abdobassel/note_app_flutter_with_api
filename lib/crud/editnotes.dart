import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Column(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                maxLines: 1,
                decoration: InputDecoration(
                    filled: true,
                    labelText: "Tilte",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.note)),
              ),
              TextFormField(
                maxLength: 300,
                maxLines: 4,
                decoration: InputDecoration(
                    filled: true,
                    labelText: "Note Here",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.note)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Add img"),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                ),
                onPressed: () {},
                child: Text("Add This Note"),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
