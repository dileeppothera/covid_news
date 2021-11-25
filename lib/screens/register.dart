import 'package:covid_news/constants/loading.dart';
import 'package:covid_news/services/ath.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pwd = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              centerTitle: true,
              elevation: 0.0,
              title: Text("Register"),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a proper email ' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                          ),
                          validator: (val) => val!.length < 6
                              ? 'Password needs atleast 6 characters '
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              pwd = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              print(email + pwd);
                              dynamic result =
                                  await authService.registerEmail(email, pwd);
                              if (result == null) {
                                setState(() {
                                  error =
                                      "Couldn't Register...Please Try Again!!!";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: const Text(
                            "Register User",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
