import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscoveryItem extends StatefulWidget {

  final String type;

  DiscoveryItem({ this.type });

  @override
  _DiscoveryItemState createState() => _DiscoveryItemState();
}

class _DiscoveryItemState extends State<DiscoveryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: StreamBuilder(
          stream: Firestore.instance.collection('Courses').where('type', isEqualTo: widget.type).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data.documents[index]['name']);
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
                                image: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
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
