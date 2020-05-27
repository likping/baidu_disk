import 'package:flutter/material.dart';
import './PersonalCenter.dart';
import 'package:baidu_disk/HomePageWidgets/FilesPage.dart';
class MyHomePage extends StatefulWidget{
  State createState(){
    return _MyHomePageState();
  }
}
class _MyHomePageState extends State<MyHomePage>{
  int _selectedIndex=0;
  //底部导航栏列表，
  final List<BottomNavigationBarItem> bottomNavigationBarItems=[
    BottomNavigationBarItem(icon:Icon(Icons.archive),title:Text("文件")),
    BottomNavigationBarItem(icon:Icon(Icons.person),title:Text("我的"))
  ];

  final pages=[FilesPage(allowPop: false,),PersonalCenter()];//用于底部导航栏的索引切换
  Widget build(BuildContext context){
    return Scaffold(
      //IndexedStack:索引栈？
      body:IndexedStack(
        index:_selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
//            点击，改变——selectedIndex值：状态改变使用特殊函数包裹
        onTap: (int index)=>setState(()=>_selectedIndex=index),
      ),
    );
  }
}




