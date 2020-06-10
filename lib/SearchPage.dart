import 'package:flutter/material.dart';
import 'package:baidu_disk/HomePageWidgets/SearchInputWidget.dart';
import './Interfaces/FileStore.dart';
import "./SearchHistory.dart";
import "./DbHelper.dart";
import './Constant.dart';
import "./ResultSearchPage.dart";
class SearchPage extends StatefulWidget{
  /*
    实验3：todo
   */

  FileStore fileStore;
  String currPath;
  DbHelper searchHistoryProvider=DbHelper();
  SearchPage(this.fileStore,{this.currPath});
  State createState(){
//    return SearchPageState();
  return _SearchPage();
  }

}
class _SearchPage extends State<SearchPage>{
  var _historywords=List<SearchHistory>();
  //搜索框提交事件，传入搜索框输入的关键词
  void _onSubmitted(String message){


        widget.searchHistoryProvider.insert(new SearchHistory(message)).then((value){
             setState(() {
                  _historywords.insert(0,value);
             });
        });
        /*跳转页面*/
        Navigator.push(
            context,MaterialPageRoute(
            builder: (context)=>
               ResultSearchPage(message)
        )
        );
  }
  //列表控件删除事件，传入关键词在列表中的位置
  void _onDeleted(int id){

    widget.searchHistoryProvider.deleteById(id).then((value){
      setState(() {
         for(var e in _historywords){
           if(e.id==id){
             _historywords.remove(e);
             return;
           }
         }
      });
    });
  }
  //一键清空
  void _onCleared(){

    widget.searchHistoryProvider.deleteAll().then((value){
      setState(() {
        _historywords.clear();
      });
    });
  }
  TextEditingController editingController=TextEditingController();
  void _onTapHistory(String key){
    editingController.text=key;
    /*跳转页面*/
    Navigator.push(
        context,MaterialPageRoute(
        builder: (context)=>
            ResultSearchPage(key)
    )
    );
  }
  /*初始化*/
  void initState() {
    Constant.dbName = "searchHistory.db";
    Constant.dbVersion = 1;
    Constant.searchHistoryTable = "shTable";

    widget.searchHistoryProvider
        .query()
        .then((list) =>
        setState(() {
          _historywords = list!=null?list:[];

        }));
  }
  //列表元素控件，传入关键词和关键词在列表中的索引
  Widget _buildItemLog(SearchHistory searchHistory){
    return
      new Container(
          height: 30,
          width: 360,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(left: 40),
          child:  new Row(
            children: <Widget>[

              new SizedBox(
                width:20,
                height: 20,
                child: Image.asset("assets/time.png"),

              ),
              new Container(
                  height: 30,
                  width: 250,
                  child:new Center(
                    child: FlatButton(
                      onPressed: (){_onTapHistory(searchHistory.keyword);},
                      child: Text(searchHistory.keyword),
                    )
                  )
              ),
              new SizedBox(
                width: 30,
                height: 30,
                child: FlatButton(
                  //TODO 删除本项
                    onPressed: ()=>_onDeleted(searchHistory.id),
                    //消去按钮对内部控件控件的挤压
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child:new SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/delete.png"),
                    )
                ),
              )
            ],
          ),
      );
  }
  Widget _buildSearchBarWidget(){
    return new Container(
        height:50,
        width: 360,
        decoration: BoxDecoration(
        ),
        child:new Row(
          children: <Widget>[
            new Container(
              height: 35,
              width: 280,
              margin: EdgeInsets.only(left:23),
              //TODO 实现状态更新和数据添加
              child: SearchInputWidget(
                onTap: null,
                onSubmitted:_onSubmitted,
                edController: editingController,
              ),
            ),
            new SizedBox(
              width: 50,
              height: 35,
              child: new FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 8),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: new Text("取消",
                  style:TextStyle(fontSize: 15.0,color: Colors.blue),
                ),
              ) ,
            )
          ],
        )
    );
  }
  Widget _buildSearchHistoryListWidget(){
    return Center(
        child: (null==this._historywords||this._historywords.length==0)
            ?new Container(
          child: new Text("无历史数据"),
        ) :ListView.builder(
          //物理滑块
          physics: BouncingScrollPhysics(),
          //shrink--收缩
          //Wrap--包裹
          shrinkWrap: true,
          itemCount: this._historywords.length,

          itemBuilder: (BuildContext context,int index){//遍历每个文件信息创建相应的显示图片
            return  _buildItemLog(this._historywords[index]);
          },
        )
    );
  }
  Widget _buildHistoryTip(){
    return  new Container(
      width: 360,
      height: 35,
      child:  new Stack(
        children: <Widget>[
          new Positioned(
              left:30,
              child: new Text(
                "搜索历史",
                style: new TextStyle(fontSize: 18.0,fontWeight:FontWeight.w700 ),
              )
          )
        ],
      )
      ,
    );
  }
  Widget _buildClearHistoryWidge(){
    return  new Center(
      child:
      new FlatButton(
        onPressed: _onCleared,
        child: Text("清空搜索记录",style: TextStyle(fontSize: 18.0,color: Colors.lightBlueAccent),),

      ) ,
    );
  }
  Widget _buildPageDefult(){
      return new Scaffold(
    appBar: new AppBar(
      title: new Text("搜索"),
    ),
    body: new Column(
          children: <Widget>[
            _buildSearchBarWidget(),
            //尝试绝对定位布局
            _buildHistoryTip(),
            _buildSearchHistoryListWidget(),
            new Expanded(child:new Container()),
            _buildClearHistoryWidge()
          ],
  ));
  }
  Widget build(BuildContext context){
      return _buildPageDefult();
  }
}

