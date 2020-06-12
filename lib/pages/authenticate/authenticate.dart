import 'package:flutter/material.dart';
import 'package:flutterapp/pages/authenticate/sign_in.dart';
import 'package:flutterapp/pages/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {

  bool showSignIn;

  Authenticate({ this.showSignIn });

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  

  void toggleView() {
    setState(() => widget.showSignIn = !widget.showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showSignIn) {
      return SignIn(toggleView: toggleView);
    }
    else {
      return SignUp(toggleView: toggleView);
    }
  }
}
