import 'package:flutter/material.dart';

class SearchHistoryWidget extends StatefulWidget {
  Set<String> historyWords = Set<String>();

  SearchHistoryWidget(this.historyWords);

  @override
  State<StatefulWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  void _serachWord(String word) {
    setState(() {
      widget.historyWords.add(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('搜索历史',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w600))
          ],
        ),
        Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.historyWords.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHistoryItem(index);
                })),
        Center(
          child: FlatButton(
            child: new Text('清空历史记录', style: TextStyle(color: Colors.blue)),
            onPressed: () => setState(() => widget.historyWords.clear()),
            splashColor: Colors.transparent, // 去掉点击阴影效果
            highlightColor: Colors.transparent, // 去掉点击阴影效果
          ),
        )
      ],
    );
  }

  Widget _buildHistoryItem(int index) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: ListTile(
          leading: Icon(Icons.history),
          title: Text(widget.historyWords.elementAt(index)),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() => widget.historyWords
                .remove(widget.historyWords.elementAt(index))),
          ),
        ),
      ),
      onTap: () => _serachWord(widget.historyWords.elementAt(index)),
    );
  }
}
