import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/discovery_item.dart';
import 'package:flutterapp/pages/discovery/lesson.dart';
import 'package:flutterapp/services/course.dart';
import 'package:flutterapp/pages/discovery/discovery_detail.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseService _course = CourseService();
  String uid;

  @override
  void initState() {
    super.initState();
    _course.getUserID().then((String result) {
      setState(() {
        uid = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: _course.getUserCourseByUser(uid),
          builder: (context, snapshot1) {
            if (!snapshot1.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot1.data.documents.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: _course.getCourseDetail(
                      snapshot1.data.documents[index]['course_id']),
                  builder: (context, snapshot2) {
                    if (!snapshot2.hasData)
                      return Text('');
                    else {
                      if (snapshot2.data['type'] == 'course') {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPage(
                                      courseID: snapshot1.data.documents[index]
                                          ['course_id'],
                                    ),
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Image.network(
                                  snapshot2.data['url'],
                                  fit: BoxFit.fill,
                                  height: 200,
                                ),
                                ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'images/flutter-icon.png'),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    snapshot2.data['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot2.data['publisher'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
