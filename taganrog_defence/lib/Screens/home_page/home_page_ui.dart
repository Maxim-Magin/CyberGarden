import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/Images/images.dart';
import 'package:taganrog_defence/Screens/photo_gallery/photo_gallery_widget.dart';
import 'package:taganrog_defence/entities/passport.dart';
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
  FocusNode node = FocusNode();

  String _statusValue;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusValue = widget._user.getUserStatus();
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
      ),
    );
  }

  List<Widget> menuItems() {
    List<Widget> menuItems = <Widget>[
      //personal information
      personalInformation(),

      //Map
      festivalMap(),

      //bonus
      bonuses(),

      //About festival
      photoGallery(),
    ];
    return menuItems;
  }

  Widget personalInformation() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${widget._user.getUserName()}",
            style: Design.regularTextStyle(),
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
                  onChanged: (text){
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
                  onChanged: (text){
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
                  onChanged: (text){
                    widget._user.getUserMetric().chestGirth = double.parse(text);
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
                  onChanged: (text){
                    widget._user.getUserMetric().thighGirth = double.parse(text);
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
                  onChanged: (text){
                    widget._user.getUserMetric().waistGirth = double.parse(text);
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
            height: 30.0,
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
        ],
      ),
    );
  }

  Widget festivalMap() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Основные места проведения:",
          style: Design.regularTextStyle(),
          textAlign: TextAlign.center,
        ),
        Text(
          "- Пушкинская набережная",
          style: Design.regularTextStyle(),
          textAlign: TextAlign.center,
        ),
        Text(
          "- Свято-Никольский храм",
          style: Design.regularTextStyle(),
          textAlign: TextAlign.center,
        ),
        Text(
          "- Войсковая ячейка Троицкой крепости (Таганрогский музейный комплекс)",
          style: Design.regularTextStyle(),
          textAlign: TextAlign.center,
        ),
        Text(
          "- Чеховская набережная",
          style: Design.regularTextStyle(),
          textAlign: TextAlign.center,
        ),
        Image(
          image: AssetImage(ApplicationImages.festivalMap()),
        ),
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
      children: List.generate(ApplicationImages.photoGalleryLinks().length,
          (index) => PhotoGalleryItem(index)),
    );
  }

  Widget festivalInformation() {
    return Center(
      child: Text(""),
    );
  }
}
