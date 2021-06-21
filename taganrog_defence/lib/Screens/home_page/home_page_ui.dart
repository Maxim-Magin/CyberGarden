import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/Images/images.dart';
import 'package:taganrog_defence/Screens/photo_gallery/photo_gallery_widget.dart';
import 'package:taganrog_defence/entities/passport.dart';
import 'package:taganrog_defence/entities/user.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  User _user;
  Map<String, String> _partners;
  List<Image> _images;
  List<User> _users;

  HomePage({
    Key key,
    User user,
    Map<String, String> partners,
    List<Image> images,
    List<User> users,
  })  : _user = user,
        _partners = partners,
        _images = images,
        _users = users,
        super(key: key);
}

class _HomePageState extends State<HomePage> {
  int _currentItem = 0;
  FocusNode node = FocusNode();

  TextEditingController _partnerNameController = TextEditingController();
  TextEditingController _partnerLinkController = TextEditingController();

  String _statusValue;
  String _costumeValue;

  bool _visible = false;

  TextEditingController _heightController;
  TextEditingController _weightController;
  TextEditingController _chestController;
  TextEditingController _thighController;
  TextEditingController _waistController;

  final _statusItems = [
    "Зритель",
    "Участник реконструкции",
    "Участник спортивных соревнований"
  ];

  final _costumeItems = ["Свой", "На прокат"];

  File _file;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
        widget._images.add(Image.file(_file));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusValue = widget._user.getUserStatus();
    _costumeValue = widget._user.getCostume();
    _heightController =
        TextEditingController(text: "${widget._user.getUserMetric().height}");
    _weightController =
        TextEditingController(text: "${widget._user.getUserMetric().weight}");
    _chestController = TextEditingController(
        text: "${widget._user.getUserMetric().chestGirth}");
    _thighController = TextEditingController(
        text: "${widget._user.getUserMetric().thighGirth}");
    _waistController = TextEditingController(
        text: "${widget._user.getUserMetric().waistGirth}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _partnerNameController.dispose();
    _partnerLinkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFeaecc6),
          iconTheme: IconThemeData(color: Color(0xFF2bc0e4)),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF2bc0e4)),
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
                title: !widget._user.isUserAdmin()
                    ? Text(
                        "Личная информация",
                        style: Design.regularTextStyle(),
                      )
                    : Text(
                        "Пользователи",
                        style: Design.regularTextStyle(),
                      ),
                onTap: () {
                  setState(() {
                    _currentItem = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              if (!widget._user.isUserAdmin())
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
              if (!widget._user.isUserAdmin())
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
                  "Фото галерея",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Бронирование",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  setState(() {
                    _currentItem = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Выход",
                  style: Design.regularTextStyle(),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Выход'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Вы действительно хотите выйти?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Да'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Нет'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        body: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
              ),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: menuItems()[_currentItem]),
          ),
        ),
        floatingActionButton: ((widget._user.isUserAdmin()) &&
                ((_currentItem == 4) || (_currentItem == 3)))
            ? FloatingActionButton(
                child: (_currentItem == 4)
                    ? Icon(Icons.edit)
                    : Icon(Icons.add_a_photo),
                onPressed: () {
                  if (_currentItem == 4) {
                    setState(() {
                      _visible = !_visible;
                    });
                  }
                  if (_currentItem == 3) {
                    getImage();
                  }
                },
              )
            : Container(),
      ),
    );
  }

  List<Widget> menuItems() {
    List<Widget> menuItems = <Widget>[
      personalInformation(),
      festivalMap(),
      bonuses(),
      photoGallery(),
      booking(),
    ];
    return menuItems;
  }

  Widget personalInformation() {
    if (!widget._user.isUserAdmin()) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${widget._user.getUserName()}",
              style: Design.titleTextStyle(),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "Рост, см",
                    style: Design.regularTextStyle(),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    focusNode: node,
                    controller: _heightController,
                    onChanged: (text) {
                      widget._user.getUserMetric().height = double.parse(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "Вес, кг",
                    style: Design.regularTextStyle(),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: _weightController,
                    onChanged: (text) {
                      widget._user.getUserMetric().weight = double.parse(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Обхват груди, см",
                    style: Design.regularTextStyle(),
                  ),
                  flex: 3,
                ),
                Flexible(
                  child: TextField(
                    controller: _chestController,
                    onChanged: (text) {
                      widget._user.getUserMetric().chestGirth =
                          double.parse(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  flex: 2,
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Обхват бедра, см",
                    style: Design.regularTextStyle(),
                  ),
                  flex: 3,
                ),
                Flexible(
                  child: TextField(
                    controller: _thighController,
                    onChanged: (text) {
                      widget._user.getUserMetric().thighGirth =
                          double.parse(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  flex: 2,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Обхват талии, см",
                    style: Design.regularTextStyle(),
                  ),
                  flex: 3,
                ),
                Flexible(
                  child: TextField(
                    controller: _waistController,
                    onChanged: (text) {
                      widget._user.getUserMetric().waistGirth =
                          double.parse(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  flex: 2,
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), fillColor: Colors.white),
              isExpanded: true,
              hint: Text(
                'Статус',
                style: Design.regularTextStyle(),
              ),
              items: _statusItems.map((status) {
                return DropdownMenuItem(
                  child: Text(
                    status,
                    overflow: TextOverflow.visible,
                    style: Design.regularTextStyle(),
                  ),
                  value: status,
                );
              }).toList(),
              onChanged: (status) {
                setState(() {
                  _statusValue = status;
                  widget._user.changeUserStatus(status);
                });
              },
              value: _statusValue,
            ),
            SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), fillColor: Colors.white),
              isExpanded: true,
              hint: Text(
                "Костюм",
                style: Design.regularTextStyle(),
              ),
              items: _costumeItems.map((status) {
                return DropdownMenuItem(
                  child: Text(
                    status,
                    overflow: TextOverflow.visible,
                    style: Design.regularTextStyle(),
                  ),
                  value: status,
                );
              }).toList(),
              onChanged: (status) {
                setState(() {
                  _costumeValue = status;
                });
              },
              value: _costumeValue,
            ),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${widget._user.getUserName()}",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget._users.length,
              itemBuilder: (context, index) {
                User user = widget._users[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OpenContainer(
                          //openColor: Colors.transparent,
                          closedColor: Color(0xFFeaecc6),
                          //middleColor: Colors.transparent,
                          closedBuilder: (context, open) {
                            return GestureDetector(
                              onTap: open,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "${user.getUserName()}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    Text(
                                      "${user.getUserPhone()}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    if (user.isUserAdmin())
                                      Text(
                                        "Администратор",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    if (!user.isUserAdmin())
                                      Text(
                                        "Гость",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    //SizedBox(height: 10,)
                                  ],
                                ),
                              ),
                            );
                          },
                          openBuilder: (context, close) {
                            return GestureDetector(
                              onTap: close,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                child: Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Серия паспорта",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                              widget._users[index].getUserPassport().getPassportSeries().toString(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Номер паспорта",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                              widget._users[index].getUserPassport().getPassportNumber().toString(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "ФИО",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                              widget._users[index].getUserName(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Телефон",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                              widget._users[index].getUserPhone(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Статус",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].isUserAdmin()
                                                    ? "Администратор"
                                                    : "Гость"
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Роль",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserStatus()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Костюм",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getCostume()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Рост, см",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserMetric().height.toString()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Вес, кг",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserMetric().weight.toString()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Обхват груди, см",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserMetric().chestGirth.toString()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Обхват талии, см",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserMetric().waistGirth.toString()
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide())),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Обхват бедра, см",
                                              style: Design.regularTextStyle(),
                                            ),
                                            Text(
                                                widget._users[index].getUserMetric().thighGirth.toString()
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Flexible(
                        child: Container(
                            height: 40.0,
                            width: 40.0,
                            child: FittedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (!(user == widget._user)) {
                                      widget._users.remove(user);
                                    } else {
                                      // TODO: can't remove yourself
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xFF2bc0e4),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  //padding: EdgeInsets.all(20),
                                  primary: Color(0xFFeaecc6),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
    }
  }

  Widget festivalMap() {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Основные места проведения:",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Пушкинская набережная",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Свято-Никольский храм",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Войсковая ячейка Троицкой крепости (Таганрогский музейный комплекс)",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Чеховская набережная",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.0,
            ),
            InteractiveViewer(
              panEnabled: true,
              minScale: 1,
              maxScale: 6,
              child: Image(
                image: AssetImage(ApplicationImages.festivalMap()),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget bonuses() {
    return Center(
      child: Stack(
        children: [
          Text(
            "Бонусы и возможности",
            style: Design.titleTextStyle(),
            textAlign: TextAlign.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Доступ ко всем локациям фестиваля",
                style: Design.regularTextStyle(),
                textAlign: TextAlign.center,
              ),
              Text(
                "Съемка от профессиональных фотографов",
                style: Design.regularTextStyle(),
                textAlign: TextAlign.center,
              ),
              if (widget._user.getUserPassport().getPassportType() ==
                  PassportType.Standard)
                Text(
                  "Скидка 5% в заведениях HoReCa",
                  style: Design.regularTextStyle(),
                  textAlign: TextAlign.center,
                )
              else
                Text(
                  "Скидка 10% в заведениях HoReCa",
                  style: Design.regularTextStyle(),
                  textAlign: TextAlign.center,
                ),
              if (widget._user.getUserPassport().getPassportType() ==
                  PassportType.VIP)
                Text(
                  "Доступ в VIP зоны",
                  style: Design.regularTextStyle(),
                  textAlign: TextAlign.center,
                )
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Image(
                image: AssetImage(ApplicationImages.code()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget photoGallery() {
    return GridView.count(
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      crossAxisCount: 2,
      children: List.generate(
          widget._images.length,
          (index) => Stack(
                children: [
                  PhotoGalleryItem(index, widget._images),
                  if (widget._user.isUserAdmin())
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          height: 40.0,
                          width: 40.0,
                          child: FittedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget._images.remove(widget._images[index]);
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Color(0xFF2bc0e4),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                //padding: EdgeInsets.all(20),
                                primary: Color(0xFFeaecc6),
                              ),
                            ),
                          )),
                    ),
                ],
              )),
    );
  }

  Widget booking() {
    return ListView(
      children: [
        Column(
          children: [
            Text(
              "При бронировании мест в отелях и столиков в кафе используйте промокод",
              textAlign: TextAlign.center,
              style: Design.regularTextStyle(),
            ),
            Text(
              "\"TAGANROGDEFENCE\"",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Наши партнеры:",
              textAlign: TextAlign.center,
              style: Design.regularTextStyle(),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget._partners.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${widget._partners.keys.toList()[index]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        InkWell(
                            child: Text(
                              '${widget._partners.values.toList()[index]}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Montserrat",
                              ),
                            ),
                            onTap: () => launch(
                                '${widget._partners.values.toList()[index]}')),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                    if (widget._user.isUserAdmin())
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              widget._partners.remove(
                                  widget._partners.keys.toList()[index]);
                            });
                          })
                  ],
                );
              },
            ),
            if (_visible)
              Column(
                children: [
                  TextField(
                    controller: _partnerNameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Название',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _partnerLinkController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ссылка',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget._partners[_partnerNameController.text] =
                            _partnerLinkController.text;
                        _visible = false;
                        _partnerNameController.clear();
                        _partnerLinkController.clear();
                      });
                    },
                    child: Text(
                      'Добавить',
                      style: TextStyle(fontSize: 28.0),
                    ),
                    style:
                        ElevatedButton.styleFrom(primary: Design.themeColor()),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }
}
