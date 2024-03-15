import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    {"note": "promes sso notes svsye s", "image": "pic1.png"},
    {"note": "promes sso notes svsye s", "image": "pic1.png"},
    {"note": "promes sso notes svsye s", "image": "pic1.png"},
    {"note": "promes sso notes svsye s", "image": "pic1.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('addnotes');
              print('new note');
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          appBar: AppBar(),
          body: Container(
            child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, i) {
                  return Dismissible(
                      key: Key("$i"),
                      child: ListNotes(
                        notes: notes[i],
                      ));
                }),
          )),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes;

  const ListNotes({super.key, this.notes});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "images/pic1.png",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              subtitle: IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
              title: Text('${notes['note']}'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("editnotes");
                },
                icon: Icon(Icons.edit_note),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
