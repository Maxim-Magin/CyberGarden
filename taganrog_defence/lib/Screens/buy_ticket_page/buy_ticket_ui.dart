import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/Screens/log_in_page/log_in_bloc.dart';
import 'package:taganrog_defence/Screens/log_in_page/log_in_ui.dart';
import 'package:taganrog_defence/bloc/bloc_provider.dart';

class TicketBuyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TicketBuyPageState();
}

class _TicketBuyPageState extends State<TicketBuyPage> {
  final _nameTextController = TextEditingController();
  final _phoneTextController = TextEditingController();

  String _statusValue;
  String _passportValue;

  final _statusItems = [
    "Зритель",
    "Участник реконструкции",
    "Участник спортивных соревнований"
  ];

  final _passportItems = ["Стандартный", "VIP"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTextController.dispose();
    _phoneTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: Container(
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
                Container(
                  width: 280,
                  color: Colors.white,
                  child: TextField(
                    controller: _nameTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ФИО',
                    ),
                  ),
                ),
                Container(
                  width: 280,
                  color: Colors.white,
                  child: TextField(
                    controller: _phoneTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Телефон',
                    ),
                  ),
                ),
                Container(
                  width: 280.0,
                  color: Colors.white,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white),
                    isExpanded: true,
                    hint: Text(
                      'Статус',
                    ),
                    items: _statusItems.map((status) {
                      return DropdownMenuItem(
                        child: Text(
                          status,
                          overflow: TextOverflow.visible,
                        ),
                        value: status,
                      );
                    }).toList(),
                    onChanged: (status) {
                      setState(() {
                        _statusValue = status;
                      });
                    },
                    value: _statusValue,
                  ),
                ),
                Container(
                    width: 280,
                    color: Colors.white,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      hint: Text(
                        'Паспорт',
                      ),
                      items: _passportItems.map((passport) {
                        return DropdownMenuItem(
                          child: Text(
                            passport,
                            overflow: TextOverflow.visible,
                          ),
                          value: passport,
                        );
                      }).toList(),
                      onChanged: (passport) {
                        setState(() {
                          _passportValue = passport;
                        });
                      },
                      value: _passportValue,
                    )),
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            Color(0xFFE0E0E0),
                            Color(0xFFBDBDBD),
                            Color(0xFF757575),
                            Color(0xFF424242),
                          ])),
                  child: ButtonTheme(
                    minWidth: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Design.themeColor()),
                      child: Container(
                        child: Text(
                          'Купить билет',
                          style:
                          TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              BlocProvider(
                                child: LogInPage(),
                                bloc: LogInBloc(),
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
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
