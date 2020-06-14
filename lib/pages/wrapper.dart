import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/pages/home/welcome.dart';
import 'package:flutterapp/pages/home/home.dart';
import 'package:flutterapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    if(user == null) {
      return WelcomePage();
    }
    else {
      return HomePage();
    }
  }
}
