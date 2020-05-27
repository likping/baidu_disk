import 'search_history.dart';
import 'package:flutter/material.dart';
import 'search_input.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  Set<String> historyWords = ['测试关键词1'].toSet();

  void initState(){
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            _buildSerachInput(),
            Container(height: 15),
            Expanded(child: SearchHistoryWidget(historyWords)),
          ],
        ),
      ),
    );
  }

  void onSubmittedSearchWord(String value) {
    value = value.trim();
    if (value.length == 0) return;

    setState(() => historyWords.add(value));
  }

  Widget _buildSerachInput() {
    return Container(
      height: 35,
      child: Row(
        children: <Widget>[
          Expanded(
              child: SearchInputWidget(
                onSubmitted: onSubmittedSearchWord,
              )),
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: FlatButton(
              child: new Text('取消', style: TextStyle(color: Colors.blue)),
              onPressed: () => setState(() => Navigator.of(context).pop()),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            ),
          ),
        ],
      ),
    );
  }
}
