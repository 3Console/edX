import 'package:flutter/material.dart';
import 'package:flutterapp/pages/wrapper.dart';
import 'package:flutterapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
