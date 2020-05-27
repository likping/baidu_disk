import 'package:flutter/material.dart';
import "../HomePageWidgets/SearchInputWidget.dart";
/*取消按钮*/
class SearchPageComponents{
   static Widget buildSearchInput({Function onPress,Function onSubmit}) {
    return Container(
      height: 35,
      child: Row(
        children: <Widget>[
          Expanded(
              child: SearchInputWidget(
                onSubmitted:onSubmit ,
              )),
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: FlatButton(
              child: new Text('取消', style: TextStyle(color: Colors.blue)),
              onPressed:onPress ,
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            ),
          ),
        ],
      ),
    );
  }
   static Widget seth(){

   }
}
