import 'package:flutter/material.dart';
import 'package:taganrog_defence/Design/design.dart';
import 'package:taganrog_defence/Images/images.dart';
import 'package:taganrog_defence/Screens/log_in_page/log_in_bloc.dart';
import 'package:taganrog_defence/Screens/log_in_page/log_in_ui.dart';
import 'package:taganrog_defence/bloc/bloc_provider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: intro(),
      ),
    );
  }

  Widget intro() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: introWidgetsList(context).length,
              onPageChanged: (int page) {
                getChangedPageAndMoveBar(page);
              },
              itemBuilder: (context, index) {
                _currentPageValue = index;
                return introWidgetsList(context)[index];
              }),
        ),
        Positioned(
          bottom: 10.0,
          child: Container(
              //height: 100,
              margin: EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  if (_currentPageValue != introWidgetsList(context).length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              BlocProvider(
                                child: LogInPage(),
                                bloc: LogInBloc(),
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
                        "Пропустить",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < introWidgetsList(context).length; ++i)
                        if (i == _currentPageValue)
                          circleBar(true)
                        else
                          circleBar(false)
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  List<Widget> introWidgetsList(BuildContext context) {
    double _iconItemHeight = MediaQuery.of(context).size.height / 7;
    double _iconItemWidth = MediaQuery.of(context).size.width / 3;
    List<Widget> widgets = [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ApplicationImages.backgroundDefenders()),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
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
            )
          ],
        ),
      ),
      Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                child: Text(
                  'Международный фестиваль «Оборона Таганрога 1855 года» - фестиваль, реконструирующий наиболее яркий и героический эпизод Крымской (Восточной) войны 1853-1856 гг в Приазовье - оборону города Таганрога.',
                  style: Design.regularTextStyle(),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: _iconItemWidth,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(ApplicationImages.calendar()),
                            height: _iconItemHeight,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'Организован в 2016 году',
                            style: Design.iconTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  Container(
                      width: _iconItemWidth,
                      child: Column(
                        children: [
                          Image(
                            image:
                                AssetImage(ApplicationImages.locationPointer()),
                            height: _iconItemHeight,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Более 30 площадок',
                            style: Design.iconTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  Container(
                    width: _iconItemWidth,
                    child: Column(
                      children: [
                        Container(
                          height: _iconItemHeight,
                          child: Image(
                            image: AssetImage(ApplicationImages.team()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          '45 тысяч человек',
                          style: Design.iconTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Стандартный пакет:',
                  style: Design.titleTextStyle(),
                ),
                Column(
                  children: [
                    Text(
                      '- доступ ко всем локациям фестиваля',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- возможность принятия участия в реконструкциях',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- получение бонусов в заведениях HoReCa',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- профессиональная съемка',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Column(
              children: [
                Text(
                  'VIP:',
                  style: Design.titleTextStyle(),
                ),
                Column(
                  children: [
                    Text(
                      '- доступ в VIP-зоны',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- получение памятных подарков по окончании фестиваля',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- скидки в заведениях HoReCa',
                      style: Design.regularTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        'Вы можете принять участие как:',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '- зритель',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '- участник реконструкци боя',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '- участник реконструкции бала',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '- участник спортивных состязаний',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '- участник исторического променада',
                        style: Design.regularTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BlocProvider(
                              child: LogInPage(),
                              bloc: LogInBloc(),
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
                      "Принять участие!",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
    ];
    return widgets;
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Design.circleItemColor() : Design.disableColor(),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  int _currentPageValue = 0;

  void getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }
}
