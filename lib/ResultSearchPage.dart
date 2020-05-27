import 'package:flutter/material.dart';
import "./miroCompnents/SearchPageComponents.dart";
import  "./SystemFileStore.dart";
import 'dart:io';
import "./HomePageWidgets/FilesListWidget.dart";
import"./SystemFile.dart";
import "./DiskFile.dart";
import "./PathUtils.dart";
import "./HomePageWidgets/FilesPage.dart";

class ResultSearchPage extends StatefulWidget{

  State createState(){
//    return SearchPageState();
    return _RsultSearchPageState();
  }
  String keyword;
  ResultSearchPage(this.keyword);
}
class _RsultSearchPageState extends State<ResultSearchPage>{

    Widget build(BuildContext buildContext){
      return new FilesPage(keyword: widget.keyword);
    }
}
