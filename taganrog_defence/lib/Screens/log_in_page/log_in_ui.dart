import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/Images/images.dart';
import 'package:taganrog_defence/Screens/buy_ticket_page/buy_ticket_bloc.dart';
import 'package:taganrog_defence/Screens/buy_ticket_page/buy_ticket_ui.dart';
import 'package:taganrog_defence/Screens/home_page/home_page_bloc.dart';
import 'package:taganrog_defence/Screens/home_page/home_page_ui.dart';
import 'package:taganrog_defence/bloc/bloc_provider.dart';
import 'package:taganrog_defence/entities/metric.dart';
import 'package:taganrog_defence/entities/passport.dart';
import 'package:taganrog_defence/entities/user.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _seriesController = TextEditingController();
  final _numberController = TextEditingController();

  List<User> _users = [
    User(
      name: "Магин Максим Сергеевич",
      phone: "88888888888",
      passport: Passport(series: 1, number: 1, type: PassportType.Standard),
      metric: Metric(
        weight: 85.0,
        height: 183.0,
        chestGirth: 105.0,
        thighGirth: 63.0,
        waistGirth: 88.0,
      ),
      status: "Зритель",
      isAdmin: false,
    ),
    User(
      name: "Иванов Иван Иванович",
      phone: "88888888888",
      passport: Passport(series: 2, number: 2, type: PassportType.Standard),
      metric: Metric(
        weight: 85.0,
        height: 183.0,
        chestGirth: 105.0,
        thighGirth: 63.0,
        waistGirth: 88.0,
      ),
      status: "Зритель",
      isAdmin: true,
    ),
  ];

  Map<String, String> _partners = {
    "Темеринда": "https://www.temirinda.ru/",
    "Гринвич парк": "https://greenwich-park.ru/",
  };

  List<Image> _images = [
    Image(
      image: AssetImage(ApplicationImages.getFirstImage()),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage(ApplicationImages.getDefendersImage()),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage(ApplicationImages.getSmokeImage()),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage(ApplicationImages.getTheBestImage()),
      fit: BoxFit.cover,
    ),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _numberController.clear();
    _seriesController.clear();
    _numberController.dispose();
    _seriesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFeaecc6),
          iconTheme: IconThemeData(color: Color(0xFF2bc0e4)),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "фестиваль",
                        style: Design.titleTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "\"Оборона Таганрога\"".toUpperCase(),
                        style: Design.titleTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 280,
                        color: Colors.white,
                        child: TextField(
                          controller: _seriesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Серия паспорта фестиваля',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 280,
                        color: Colors.white,
                        child: TextField(
                          controller: _numberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Номер паспорта фестиваля',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Войти',
                          style: TextStyle(fontSize: 28.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Design.themeColor()),
                        onPressed: () {
                          try{
                            var passingUser = _users.firstWhere((user) =>
                            (user
                                .getUserPassport()
                                .getPassportNumber()
                                .toString() ==
                                _numberController.text) &&
                                (user
                                    .getUserPassport()
                                    .getPassportSeries()
                                    .toString() ==
                                    _seriesController.text));
                            if (passingUser != null) {
                              _numberController.clear();
                              _seriesController.clear();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                      BlocProvider(
                                        child: HomePage(
                                          user: passingUser,
                                          partners: _partners,
                                          images: _images,
                                          users: _users,
                                        ),
                                        bloc: HomePageBloc(),
                                      ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return ScaleTransition(
                                      scale: Tween<double>(
                                        begin: 0.0,
                                        end: 1.0,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.fastOutSlowIn,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          catch(ex){
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Ошибка'),
                                    content: Text('Данный пользователь не зарегистрирован'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Ок'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BlocProvider(
                                child: TicketBuyPage(_users),
                                bloc: TicketBuyBloc(),
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0.0,
                                    end: 1.0,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.fastOutSlowIn,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Купить билет',
                          style: TextStyle(fontSize: 28.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Design.themeColor()),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }


}
