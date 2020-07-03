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
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Register",
          style: TextStyle(fontFamily: 'Open Sans', fontSize: 22, color: Colors.blue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              const Image(
                image: AssetImage('assets/images/1200px-EdX.svg.png'),
                  height: 50,
                  width: 100,
              ),
              TextFormField(
                style: TextStyle(fontSize: 18),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 5.0, color: Colors.lightBlue.shade50),
                    ),
                  ),
                validator: (val) => val.isEmpty ? 'Please enter your Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 5.0, color: Colors.lightBlue.shade50),
                  ),
                ),
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Enter a 8+ characters password' : null,
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
                    'Create my account',
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
