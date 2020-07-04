import 'package:flutter/material.dart';
import 'package:flutterapp/services/course.dart';
import 'package:flutterapp/pages/discovery/discovery_detail.dart';
import 'package:flutterapp/pages/shared/item_card.dart';

class DiscoveryItem extends StatefulWidget {
  final String type;

  DiscoveryItem({this.type});

  @override
  _DiscoveryItemState createState() => _DiscoveryItemState();
}

class _DiscoveryItemState extends State<DiscoveryItem> {
  final CourseService _course = CourseService();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: _course.getCourseByType(widget.type),
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
                      'Viewing in $count item' + '${count > 1 ? 's' : ''}',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
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
                                      'course_id': snapshot
                                          .data.documents[index].documentID,
                                      'name': snapshot.data.documents[index]
                                          ['name'],
                                      'url': snapshot.data.documents[index]
                                          ['url'],
                                      'publisher': snapshot.data.documents[index]
                                          ['publisher'],
                                      'status': snapshot.data.documents[index]
                                          ['status'],
                                      'type': snapshot.data.documents[index]
                                          ['type'],
                                      'description': snapshot.data.documents[index]
                                          ['description'],
                                      'length': snapshot.data.documents[index]
                                          ['length'],
                                      'effort': snapshot.data.documents[index]
                                          ['effort'],
                                      'level': snapshot.data.documents[index]
                                          ['level'],
                                      'language': snapshot.data.documents[index]
                                          ['language'],
                                      'subtitle': snapshot.data.documents[index]
                                          ['subtitle']
                                    })));
                          },
                          child: buildItemCard(
                              context,
                              snapshot.data.documents[index]['url'],
                              snapshot.data.documents[index]['name'],
                              snapshot.data.documents[index]['publisher']),
                        ),
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
