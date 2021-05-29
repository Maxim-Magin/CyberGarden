import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/entities/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  final User _user;
  HomePage({Key key, User user})
      : _user = user,
        super(key: key);
}

class _HomePageState extends State<HomePage> {
  int _currentItem = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${widget._user.getUserName()}",
                        style: Design.regularTextStyle(),
                      ),
                      Text(
                        "${widget._user.getUserPhone()}",
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              ListTile(
                title: Text(
                  "Личная информация",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Карта фестиваля",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 1;
                  });

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Бонусы",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "О фестивале",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 3;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: menuItems()[_currentItem],
      ),
    );
  }

  List<Widget> menuItems() {
    List<Widget> menuItems = <Widget>[
      //personal information
      personalInformation(),

      //Map
      Container(),

      //bonus
      Container(),

      //About festival
      Container()
    ];
    return menuItems;
  }

  Widget personalInformation() {
    return ListView(
      children: [
        Text(
          "ФИО",
          style: Design.regularTextStyle(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Рост",
              style: Design.regularTextStyle(),
            ),
            Text
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Вес",
              style: Design.regularTextStyle(),
            ),
            Text(
              "х",
              style: Design.regularTextStyle(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Обхват груди",
              style: Design.regularTextStyle(),
            ),
            Text(
              "х",
              style: Design.regularTextStyle(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Обхват бедра",
              style: Design.regularTextStyle(),
            ),
            Text(
              "х",
              style: Design.regularTextStyle(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Обхват талии",
              style: Design.regularTextStyle(),
            ),
            Text(
              "х",
              style: Design.regularTextStyle(),
            ),
          ],
        ),
      ],
    );
  }
}
