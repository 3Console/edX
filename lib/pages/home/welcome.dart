import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/pages/authenticate/authenticate.dart';
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
            SizedBox(height: 50),
            Text("Courses from the world's best universities in your pocket.",
              style: TextStyle(fontSize: 22, color: Colors.blue),),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Courses',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 32.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        SizedBox(
          width: 250,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(showSignIn: false),
                )
              );
            },
            elevation: 10,
            color: Colors.blue,
            child: Text('Create your Account'),
          ),
        ),
        SizedBox(width: 5),
        SizedBox(
          width: 120,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authenticate(showSignIn: true),
                  )
              );
            },
            elevation: 10,
            color: Colors.white,
            child: Text('Log in'),
          ),
        ),
      ],
    );
  }
}
