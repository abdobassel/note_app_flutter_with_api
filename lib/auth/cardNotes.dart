import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final String title;
  final String body;

  const CardNote({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("editnotes");
      },
      child: Card(
        color: const Color.fromARGB(255, 212, 179, 59), //
        margin: EdgeInsets.all(7),
        child: ListTile(
          leading: Image.asset(
            "images/note.png",
            fit: BoxFit.cover,
            width: 60, // تعديل حجم الصورة الرمزية حسب الرغبة
            height: 60,
          ),
          title: Text(title),
          subtitle: Text(body),
        ),
      ),
    );
  }
}
