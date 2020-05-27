import 'package:flutter/material.dart';
import "./SearchHistory.dart";
import 'package:baidu_disk/Enum/SearchHistoryEvent.dart';
typedef OnSearchHistoryEventCallback=void Function(
    SearchHistoryEvent event,SearchHistory history

    );
class SearchHistoryWidget extends StatefulWidget{
  var historyWords=List<SearchHistory>();
  var searchKeyWord;
  OnSearchHistoryEventCallback eventCallback;
  SearchHistoryWidget(this.historyWords,{this.searchKeyWord,this.eventCallback});
  State<StatefulWidget> createState()=>_SearchHistoryWidgetState();
}
class _SearchHistoryWidgetState extends State<SearchHistoryWidget>{
  var _historyWords=List<SearchHistory>();
  void initState()=>_refreshSearchHistory();
  void _refreshSearchHistory(){
    _historyWords=widget.historyWords.toList();
    if(widget.searchKeyWord !=null && widget.historyWords.isNotEmpty){
      _historyWords.retainWhere((test)=>test.keyword
          .toLowerCase()
          .contains(widget.searchKeyWord?.toString().toLowerCase())
      );
    }
  }
  void _sendEvent(SearchHistoryEvent  event,SearchHistory history){

  }
  Widget build(BuildContext context){
    return null;
  }
  void didUpdateWidget(SearchHistoryWidget oldWidget){

  }
  Widget _buildHistoryItem(int index){

  }

}