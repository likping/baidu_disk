import 'package:flutter/material.dart';
//聚焦事件---鼠标在上面时的事件
typedef SearchInputonFocusCallback=void Function();
//搜索框输入完成后，启动搜索，触发的事件
typedef SearchInputonSubmittedCallback=void Function(String value);
//搜索框
class SearchInputWidget extends StatelessWidget{
  //属性
  SearchInputonFocusCallback onTap;
  SearchInputonSubmittedCallback onSubmitted;
  TextEditingController edController;
  //构造函数
  SearchInputWidget({this.onTap,this.onSubmitted,this.edController});
  Widget build(BuildContext context){
    return TextField(
      onTap:onTap,
      controller: edController,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText:"搜索网盘文件",
          filled:true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left:0),
          border:OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)
          ),
          //前缀图标
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
          )
      ),
    );
  }
}