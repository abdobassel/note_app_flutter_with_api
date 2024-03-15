import 'package:flutter/material.dart';

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _SigupState();
}

class _SigupState extends State<Sigup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Image.asset('images/pic3.png'),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      prefixIcon: Icon(Icons.person),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: " Email",
                      prefixIcon: Icon(Icons.password_rounded),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      prefixIcon: Icon(Icons.password_rounded),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('if you have an account  ?'),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('login');
                          },
                          child: Text(
                            'Click here to login',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Create',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  )
                ],
              )))
        ]),
      ),
    );
  }
}
