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
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Sign In",
          style: TextStyle(fontFamily: 'Open Sans', fontSize: 22, color: Colors.blue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Image(
                image: NetworkImage('https://www.edx.org/sites/default/files/upload/edx-3001.png'),
                height: 100,
                width: 200,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username or e-mail address',
                  contentPadding: const EdgeInsets.fromLTRB(0,10,0,0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 5.0, color: Colors.lightBlue.shade50),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Please enter your username or e-mail address and try again' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 5.0, color: Colors.lightBlue.shade50),
                  ),
                ),
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Please enter your password and try again' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: 400.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
      //              side: BorderSide(color: Colors.lightBlue.shade50),
                  ),
                  child: Text(
                    'Sign In',
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
