import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
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
                onPressed: () {},
                child: Text("Add This Note"),
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
                    onTap: () {},
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
                    onTap: () {},
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
