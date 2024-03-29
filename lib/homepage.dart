import 'package:flutter/material.dart';
import 'package:notes_flutter/auth/cardNotes.dart';
import 'package:notes_flutter/auth/login.dart';
import 'package:notes_flutter/crud/editnotes.dart';
import 'package:notes_flutter/endpoints.dart';
import 'package:notes_flutter/main.dart';
import 'package:notes_flutter/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Crud crud = Crud();

  Future<dynamic> getNotes() async {
    try {
      var response =
          await crud.postRequest(NOTES, {"user_id": sharedPrefrence.get('id')});
      if (response['status'] == "success") {
        return response['data'];
      } else if (response['status'] == "no data") {
        print('no Data for this user');
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('addnotes');
          },
          child: Icon(Icons.add_comment),
        ),
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: Text('MY Notes'),
          backgroundColor: Colors.lightBlue[50],
          actions: [
            IconButton(
              onPressed: () async {
                sharedPrefrence
                    .clear(); // حذف جميع البيانات من SharedPreferences
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                ); // توجيه المستخدم إلى صفحة تسجيل الدخول بعد تسجيل الخروج
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: FutureBuilder(
          future: getNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List notes = snapshot.data;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key("$index"),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) async {
                      var response = await crud.postRequest(DELETE_NOTE, {
                        "note_id": '${notes[index]["id"]}',
                        "img_name": '${notes[index]["img"]}',
                      });
                      if (response != null &&
                          response['status'] != null &&
                          response['status']) {
                        print('Success deleted');
                        ShowToast(
                            text: 'Deleted Note', state: ToastStates.SUCCESS);
                        Navigator.of(context).pushNamed("homepage");
                      } else {
                        print('Failed Deleted');
                        ShowToast(
                            text: 'Failed deleted Note Or No changes',
                            state: ToastStates.ERROR);
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EditNotes(
                            titleNote: '${notes[index]["title"]}',
                            bodyNote: '${notes[index]["body"]}',
                            noteId: '${notes[index]["id"]}',
                          );
                        }));
                      },
                      child: CardNote(
                        title: '${notes[index]["title"]}',
                        body: '${notes[index]["body"]}',
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No data available.'),
              );
            }
          },
        ),
      ),
    );
  }
}
