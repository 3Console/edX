import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';

class HomePage extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign out'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}