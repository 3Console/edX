import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;

  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is sign up page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            widget.toggleView();
          },
          child: Text('Sign in'),
        ),
      ),
    );
  }
}
