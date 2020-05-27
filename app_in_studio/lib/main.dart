import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
        home: new Material(
            child: new Column(children: <Widget>[
                  new Container(
                    height: 56,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      
                    ),
                    child:new Row(
                      children: <Widget>[
                        new IconButton(icon: new Icon(Icons.menu), onPressed: null),
                        new Expanded(child:new Text("LoginPage"))
                      ],
                    )

                  ),
                  new Expanded(child: new Center(child: new Text("Hello Wodl")))
    ]))));
