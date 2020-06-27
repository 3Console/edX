import 'package:flutter/material.dart';
import 'package:flutterapp/pages/discovery/discovery_item.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {

  int selectedIndex = 0;
  List categories = ['Course', 'Program', 'Degree'];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 35,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                      ? Colors.blue
                      : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: index == selectedIndex
                        ? Colors.white
                        : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 40,
          child: PageView(
            controller: _pageController,
            children: [
              DiscoveryItem(type: 'course'),
              DiscoveryItem(type: 'program'),
              DiscoveryItem(type: 'degree')
            ],
          ),
        ),
      ],
    );
  }
}
