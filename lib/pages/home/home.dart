import 'package:flutter/material.dart';
import 'package:flutterapp/pages/course/course.dart';
import 'package:flutterapp/pages/discovery/discovery.dart';
import 'package:flutterapp/pages/home/search.dart';
import 'package:flutterapp/pages/program/program.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/pages/shared/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  Widget appBarTitle = Text(
    'Discovery',
    style: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.blue,
  );

  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: globalKey,
        appBar: buildAppBar(context),
        drawer: DrawerWidget(),
        body: TabBarView(
          children: <Widget>[
            CoursePage(),
            ProgramPage(),
            DiscoveryPage(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      elevation: 1.0,
      bottom: TabBar(
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text('Course'),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text('Program'),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text('Discovery'),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: searchIcon,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          color: Colors.blue,
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ],
    );
  }
}
