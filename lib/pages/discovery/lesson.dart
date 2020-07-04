import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/video.dart';
import 'package:flutterapp/services/course.dart';

class LessonPage extends StatefulWidget {
  final String courseID;
  final String courseName;

  LessonPage({this.courseID, this.courseName});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final CourseService _course = CourseService();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseName,
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: _course.getLesson(widget.courseID),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                count = snapshot.data.documents.length;
              });
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 0, 12),
                    child: Text(
                      'Viewing in $count lesson' + '${count > 1 ? 's' : ''}',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                        url: snapshot.data.documents[index]
                                            ['video_url']),
                                    settings: RouteSettings(arguments: {
                                      'title': snapshot.data.documents[index]
                                          ['title'],
                                    }),
                                  ),
                                );
                              },
                              title: Row(
                                children: <Widget>[
                                  Image(
                                    image: AssetImage('assets/images/film.png'),
                                    height: 20,
                                    width: 20,
                                    ),
                                  SizedBox(width: 10),
                                  Text(
                                    snapshot.data.documents[index]['title'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                snapshot.data.documents[index]['detail'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
