import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is sign in page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            widget.toggleView();
          },
          child: Text('Sign up'),
        ),
      ),
    );
  }
}
