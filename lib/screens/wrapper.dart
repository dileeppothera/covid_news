import 'package:covid_news/main.dart';
import 'package:covid_news/model/user.dart';
import 'package:covid_news/screens/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Auth();
    } else {
      return HomePage();
    }
  }
}
