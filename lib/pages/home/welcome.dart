import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/pages/authenticate/authenticate.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            const Image(
              image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/EdX.svg/1200px-EdX.svg.png'),
              height: 50,
              width: 80,
            ),
            SizedBox(height: 20),
            Text("Courses from the world's best universities in your pocket.",
              style: TextStyle(fontFamily: 'Open Sans', fontSize: 22, color: Colors.blue),),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.blue),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue),
                hintText: 'Search Courses',
                hintStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                    borderRadius: BorderRadius.circular(5.0)),
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
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
//              side: BorderSide(color: Colors.lightBlue.shade50),
            ),
            child: Text('Create your Account',
                style: TextStyle(fontSize: 16)
            ),
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
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(width: 1.5, color: Colors.blue),
            ),
            child: Text('Log in',
                style: TextStyle(color: Colors.blue, fontSize: 16)
            ),
          ),
        ),
      ],
    );
  }
}
