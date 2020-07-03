import 'package:flutter/material.dart';

Widget buildItemCard(
    BuildContext context, String url, String name, String publisher) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Image.network(
        url,
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
              image: AssetImage('assets/images/flutter-icon.png'),
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          publisher,
          style: TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}
