import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_flutter/endpoints.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailctr = TextEditingController();
  TextEditingController pwctr = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  Crud crud = Crud();
  login() async {
    if (form.currentState!.validate()) {
      var respo = await crud.postRequest(LOGIN, {
        'email': emailctr.text,
        'password': pwctr.text,
      });

      if (respo['message'] == "success") {
        print('Success');
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
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
        child: Center(
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailctr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is empty >> required';
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
                          controller: pwctr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is empty >> required';
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
                              Text('if you havent account ?'),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('signup');
                                },
                                child: Text(
                                  'Click here',
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
                              onPressed: () async {
                                login();
                              },
                              child: Text(
                                'Log In',
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                        )
                      ],
                    )))
          ]),
        ),
      ),
    );
  }
}
