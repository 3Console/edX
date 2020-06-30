import 'package:flutter/material.dart';
import 'package:flutterapp/services/course.dart';

class LessonPage extends StatefulWidget {
  final String courseID;

  LessonPage({this.courseID});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final CourseService _course = CourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: _course.getLesson(widget.courseID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data.documents[index]['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
