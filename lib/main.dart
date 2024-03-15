import 'package:flutter/material.dart';

import "package:notes_flutter/auth/login.dart";
import "package:notes_flutter/auth/signup.dart";
import "package:notes_flutter/crud/addnotes.dart";
import "package:notes_flutter/crud/editnotes.dart";
import "package:notes_flutter/homepage.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
        textTheme:
            TextTheme(titleLarge: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const Sigup(),
        "homepage": (context) => const HomePage(),
        "addnotes": (context) => const AddNotes(),
        "editnotes": (context) => const EditNotes(),
      },
    );
  }
}
