import 'package:flutter/material.dart';
import 'package:taganrog_defence/bloc/bloc_provider.dart';
import 'package:taganrog_defence/start_page/start_page_bloc.dart';
import 'package:taganrog_defence/start_page/start_page_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          child: StartPage(),
          bloc: StartPageBloc(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

