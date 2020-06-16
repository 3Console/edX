import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'edX',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[200],
              ),
            ),
            accountEmail: Text(
              'Online Course',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
          ),
          ListTile(
            leading: Icon(Icons.collections_bookmark),
            title: Text('Course'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Program'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
