import 'package:flutter/material.dart';
import 'package:flutterapp/pages/shared/loading.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/pages/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('This is sign in page'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter a email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Enter a 8+ characters password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading = false;
                      });
                    }
                    else {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account? "),
                  GestureDetector(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue
                      ),
                    ),
                    onTap: () {
                      widget.toggleView();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}