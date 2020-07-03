import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/lesson.dart';
import 'package:flutterapp/services/course.dart';
import 'package:flutterapp/pages/shared/item_card.dart';


class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
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
                      if (snapshot2.data['type'] == 'program') {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPage(
                                      courseID: snapshot1.data.documents[index]
                                          ['course_id'],
                                      courseName: snapshot2.data['name'],
                                    ),
                                  ));
                            },
                            child: buildItemCard(
                                context,
                                snapshot2.data['url'],
                                snapshot2.data['name'],
                                snapshot2.data['publisher']),
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
