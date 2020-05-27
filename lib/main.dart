import 'package:flutter/material.dart';

import './LoginPage.dart';
import './MyHomePage.dart';
import "./SearchPage.dart";
import './SystemFileStore.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baidu Disk",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),

//      home:MyHomePage(),
      routes: <String,WidgetBuilder>{
          "/MyHomePage":(BuildContext context)=>new MyHomePage(),
          "/SearchPage":(BuildContext context)=>new SearchPage(SystemFileStore()),
      },
    );
  }
}
