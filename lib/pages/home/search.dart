import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          style: TextStyle(color: Colors.black, fontSize: 20),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          autofocus: true,
          onChanged: (val) {
            setState(() => searchKey = val);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print(searchKey);
          },
          child: Text('Test'),
        ),
      ),
    );
  }
}
