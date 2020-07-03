import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/lesson.dart';
import 'package:flutterapp/services/course.dart';

class DiscoveryDetail extends StatefulWidget {
  @override
  _DiscoveryDetailState createState() => _DiscoveryDetailState();
}

class _DiscoveryDetailState extends State<DiscoveryDetail> {
  final CourseService _course = CourseService();
  Map data = {};
  bool isEnrolled = false;
  String uid;

  @override
  void initState() {
    super.initState();
    _course.getUserID().then((String result) {
      setState(() {
        uid = result;
        checkEnrolledUser();
      });
    });
  }

  void checkEnrolledUser() {
    Stream<QuerySnapshot> result = _course.checkEnroll(uid, data['course_id']);
    result.first.then((value) {
      if (value.documents.length > 0) {
        setState(() {
          isEnrolled = true;
        });
      } else {
        setState(() {
          isEnrolled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return isEnrolled
        ? LessonPage(courseID: data['course_id'], courseName: data['name'])
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Discover',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              iconTheme: IconThemeData(color: Colors.blue),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data['url']),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data['name'],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              data['publisher'],
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        child: Builder(
                          builder: (context) => RaisedButton(
                            onPressed: () async {
                              String uid = await _course.getUserID();
                              if (uid != null) {
                                _course.enrollCourse(uid, data);
                                _displayToastMessage(context);
                              }
                            },
                            color: Colors.green,
                            child: Column(
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  Text(
                                    'Enroll',
                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(height: 1.5),
                                  Text(
                                    data['status'],
                                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data['description'],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Text(
                              'Length:',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(width: 70),
                            Text(
                              'Length:',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Effort:',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  _displayToastMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(width: 10),
          Text('Successful!')
        ],
      ),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
