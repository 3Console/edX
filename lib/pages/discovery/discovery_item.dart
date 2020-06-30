import 'package:flutter/material.dart';
import 'package:flutterapp/services/course.dart';
import 'package:flutterapp/pages/discovery/discovery_detail.dart';

class DiscoveryItem extends StatefulWidget {
  final String type;

  DiscoveryItem({this.type});

  @override
  _DiscoveryItemState createState() => _DiscoveryItemState();
}

class _DiscoveryItemState extends State<DiscoveryItem> {
  final CourseService _course = CourseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: _course.getCourseByType(widget.type),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscoveryDetail(),
                              settings: RouteSettings(arguments: {
                                'course_id':
                                    snapshot.data.documents[index].documentID,
                                'name': snapshot.data.documents[index]['name'],
                                'url': snapshot.data.documents[index]['url'],
                                'publisher': snapshot.data.documents[index]
                                    ['publisher'],
                                'type': snapshot.data.documents[index]['type'],
                                'description': snapshot.data.documents[index]
                                    ['description']
                              })));
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
                                image: AssetImage('images/flutter-icon.png'),
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
