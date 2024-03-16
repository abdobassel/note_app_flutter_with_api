import 'package:flutter/material.dart';
import 'package:notes_flutter/endpoints.dart';
import "dart:convert";

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _SigupState();
}

class _SigupState extends State<Sigup> {
  Crud crud = Crud();
  // key

  // conrolers
  TextEditingController emailctr = TextEditingController();
  TextEditingController pwctr = TextEditingController();
  TextEditingController username = TextEditingController();
//signup method
  GlobalKey<FormState> form = GlobalKey();
  signup() async {
    if (form.currentState!.validate()) {
      var respo = await crud.postRequest(SIGNUP, {
        'email': emailctr.text,
        'password': pwctr.text,
        'username': username.text
      });

      if (respo != null &&
          respo.containsKey("message") &&
          respo["message"] == "success") {
        print('Success');
      } else {
        print('failed');
      }
    }
  }

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
                  key: form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'username is empty >> required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailctr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is empty >> required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: " Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: pwctr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is empty >> required';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.password_rounded),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
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
                            onPressed: () {
                              signup();
                            },
                            child: Text(
                              'Create',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      )
                    ],
                  )))
        ]),
      ),
    );
  }
}
