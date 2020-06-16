import 'package:flutter/material.dart';
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
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  String _searchText = "";

  _HomePageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: buildAppBar(context),
      drawer: DrawerWidget(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      elevation: 1.0,
      actions: <Widget>[
        IconButton(
          icon: searchIcon,
          onPressed: () {
            setState(() {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(
                  Icons.close,
                  color: Colors.blue,
                );
                this.appBarTitle = TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.blue
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.blue),
                    contentPadding: EdgeInsets.only(left: 0, bottom: 0, top: 15, right: 0),
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
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

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.searchIcon = Icon(
        Icons.search,
        color: Colors.blue,
      );
      this.appBarTitle = Text(
        "Discovery",
        style: TextStyle(color: Colors.blue),
      );
      _isSearching = false;
      _controller.clear();
    });
  }
}
