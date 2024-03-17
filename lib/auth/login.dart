import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_flutter/endpoints.dart';
import 'package:notes_flutter/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

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
        print(respo['userinfo']['id']);
        print(respo['userinfo']['username']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
        sharedPrefrence.setString('id', respo['userinfo']['id']);
        sharedPrefrence.setString('username', respo['userinfo']['username']);
        sharedPrefrence.setString('email', respo['userinfo']['email']);
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/note.png',
                width: 200,
                height: 150,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
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
                          hintText: "Enter Email Address",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pwctr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is empty >> required';
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.password_rounded),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text('if you haven\'t account ?'),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('signup');
                              },
                              child: Text(
                                'Click here',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
