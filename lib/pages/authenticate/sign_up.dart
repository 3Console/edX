import 'package:flutter/material.dart';
import 'package:flutterapp/pages/shared/loading.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/pages/shared/constants.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;

  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
        title: Text('This is sign up page'),
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
                  'Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please enter a valid email';
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
                  Text("Already have an account? "),
                  GestureDetector(
                    child: Text(
                      'Sign in',
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
