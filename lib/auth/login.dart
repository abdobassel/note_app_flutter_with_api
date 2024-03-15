import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailctr = TextEditingController();
  final TextEditingController pwctr = TextEditingController();

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
                    child: Column(
                  children: [
                    TextFormField(
                      controller: emailctr,
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
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                            print("object");
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
