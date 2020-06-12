import 'package:flutter/material.dart';
import 'package:flutterapp/pages/shared/constants.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Welcome to edX'),
            SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(labelText: 'Search'),
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        SizedBox(
          width: 250,
          child: RaisedButton(
            onPressed: () {},
            elevation: 10,
            color: Colors.blue,
            child: Text('Log in'),
          ),
        ),
        SizedBox(width: 5),
        SizedBox(
          width: 120,
          child: RaisedButton(
            onPressed: () {},
            elevation: 10,
            color: Colors.white,
            child: Text('Register'),
          ),
        ),
      ],
    );
  }
}
