import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/discovery_item.dart';
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
          stream: _course.getUserCourseByType(uid, 'course'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data.documents[index]['name']);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DiscoveryDetail(),
                      //         settings: RouteSettings(arguments: {
                      //           'name': snapshot.data.documents[index]['name'],
                      //           'url': snapshot.data.documents[index]['url'],
                      //           'publisher': snapshot.data.documents[index]
                      //               ['publisher'],
                      //           'type': snapshot.data.documents[index]['type'],
                      //           'description': snapshot.data.documents[index]
                      //               ['description']
                      //         })));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.network(
                          snapshot.data.documents[index]['url'],
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
                                image: NetworkImage(
                                    'https://i.imgur.com/BoN9kdC.png'),
                              ),
                            ),
                          ),
                          title: Text(
                            snapshot.data.documents[index]['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data.documents[index]['publisher'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
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
