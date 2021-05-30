import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
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

  User _user = User(
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
      status: "Зритель");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
              ),
            ),
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
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_seriesController.text == "1")
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  BlocProvider(
                                    child: HomePage(user: _user),
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
                      },
                      child: Text(
                        'Войти',
                        style: TextStyle(fontSize: 28.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Design.themeColor()),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_numberController.text == "1")
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                BlocProvider(
                                  child: TicketBuyPage(),
                                  bloc: TicketBuyBloc(),
                                ),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
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
                          ));
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
            )),
      ),
    );
  }
}
