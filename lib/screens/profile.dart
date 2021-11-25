import 'package:covid_news/constants/other.dart';
import 'package:covid_news/main.dart';
import 'package:covid_news/screens/wrapper.dart';
import 'package:covid_news/services/ath.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  String update = '';
  @override
  void initState() {
    update = '';
    // TODO: implement initState
    super.initState();
  }

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Cov News"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: name == '' ? 'Name' : name,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Name Cannot be empty' : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: phone == '' ? 'Phone number' : phone,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Phone Cannot be empty' : null,
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          update = "Values Updated Locally";
                        });
                      }
                    },
                    child: Text("Update")),
                const SizedBox(height: 20),
                Text(
                  update,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
