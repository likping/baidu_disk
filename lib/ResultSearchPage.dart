import 'package:flutter/material.dart';
import "./HomePageWidgets/FilesPage.dart";

class ResultSearchPage extends StatefulWidget{

  State createState(){
    return _RsultSearchPageState();
  }
  String keyword;
  ResultSearchPage(this.keyword);
}
class _RsultSearchPageState extends State<ResultSearchPage>{

    Widget build(BuildContext buildContext){
      return new FilesPage(keyword: widget.keyword,allowPop: true,);
    }
}
