import 'package:flutter/material.dart';
import '../DiskFile.dart';
import '../Utils.dart';
import './SearchInputWidget.dart';
import './FilesListWidget.dart';
import '../Interfaces/FileStore.dart';
import '../SystemFileStore.dart';
import '../Enum/FilesState.dart';
import "../PathUtils.dart";
import "dart:io";
import "../SearchPage.dart";
import '../AppConfig.dart';
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";
enum ResultState{
  something,
  nothing,
  pause
}
class FilesPage extends StatefulWidget{
  //实验三添加的
  SystemFileStore fileStore;
  //根目录，是否关闭文件浏览页面
  bool allowPop=true;
  //指定的根目录
  String rootPath;
  String keyword;
    FilesPage({this.fileStore, this.rootPath="/storage/emulated/0", this.allowPop=true, this.keyword}){
      if(this.fileStore==null){
        this.fileStore=SystemFileStore();
      }
  }
  State<StatefulWidget> createState(){
    return _FilesPageState();
  }
}
class _FilesPageState extends State<FilesPage>{
  //实验三
   FileState _fileState=FileState.loaded;
   ResultState _resultState=ResultState.pause;
   String _failMsg='';

  String  _title="/";
  String _currentPath="/";
  List<DiskFile> _diskFiles;
  int _totalSearch=0;
  //搜索完成后跳转到目标文件
  void _onFocusSearchInput()async{



            Navigator.push(
              context,MaterialPageRoute(
                builder: (context)=>
                  SearchPage(widget.fileStore,currPath:_currentPath)
                )
            );

  }
  //点击文件夹时，传入磁盘文件类对象作为参数
  void _onTapDiskFile(DiskFile file){
    setState(() {
      if(0==file.isDir) return;
      _title=file.server_filename;
      _currentPath=file.path;

      _requestFiles();
    });

  }
  final _emptyDir=List<DiskFile>();


  //数据存储刷新路径 实验3
   void _requestFiles()async{
      setState(() {
        _fileState=FileState.loading;
      });

      if(widget.keyword==null){
        widget.fileStore.list(_currentPath).then((files){
          setState(() {
            _title=PathUtils.basenameWithoutExtension(_currentPath);
            _diskFiles=files;
            _fileState=FileState.loaded;
          });
        },onError:(e){
          setState(() {
            _fileState=FileState.fail;
            if(e is FileSystemException){

            }else
              _failMsg=e.toString();
          });
        });
      }else{
        widget.fileStore.search(widget.keyword,dir: _currentPath).then((files){
          setState(() {
            _title=PathUtils.basenameWithoutExtension(_currentPath);
            _diskFiles=files;
            _totalSearch=_diskFiles.length;
            print("102---totalSearch: "+ _totalSearch.toString());
            if(files!=null&&files.length>0){
              _resultState=ResultState.something;
            }else{
              _resultState=ResultState.nothing;
            }

          });
        },onError:(e){
          setState(() {
            _fileState=FileState.fail;
            if(e is FileSystemException){

            }else
              _failMsg=e.toString();
          });
        });
      }

   }
   void _onForwardDir(DiskFile file){
        if(0==file.isDir) return;
        _currentPath=file.path;
        _requestFiles();
   }

   Widget _buildResultWidget(ResultState resultState){

     switch(resultState){
       case ResultState.pause:
         return
           new Center(
             child:   new Column(children: <Widget>[
               SizedBox(height: 200),
               CircularProgressIndicator(strokeWidth: 4.0),
               Text("正在加载")
             ],)  ,
           );

       case ResultState.something:
         return SingleChildScrollView(
           padding: EdgeInsets.only(left:15,right: 15,top:10),
           child: Column(
             children: <Widget>[
               Container(
                 height: 35,
                 child: SearchInputWidget(onTap: _onFocusSearchInput,),
               ),
               Container(
                 height:25,
                 child:new Row(
                     children: <Widget>[
                       new Text("文件(${_totalSearch})")
                     ],
                 )
               ),
               Center(
                 child:
                 FilesListWidget(
                     _diskFiles,
                     onFileTap: _onTapDiskFile
                 ),
               )
             ],
           ),
         );
       case ResultState.nothing:
         return new Center(
           child: Column(//无文件就显示空文件
             children: <Widget>[
               SizedBox(height: 200,),
               Image.asset("assets/ic_gc_main_empty_folder.png"),
               Text("无文件")
             ]
         ),) ;
     }

   }
   Widget _buildFilesWidget(){
        switch (_fileState){
          case FileState.loading:
            return Column(children: <Widget>[
              SizedBox(height: 200),
              CircularProgressIndicator(strokeWidth: 4.0),
              Text("正在加载")
            ],) ;
          case FileState.loaded:
            return FilesListWidget(_diskFiles,onFileTap: _onForwardDir,);

          case FileState.fail:
            return Column(children: <Widget>[
              SizedBox(height: 200),
              IconButton(
                icon: Icon(Icons.refresh),
                iconSize: 96,
                onPressed: _requestFiles,
              ),
              Text(_failMsg)
            ],);
        }
   }
  //Future 实现js Promise的功能解决异步回调
  Future<bool> _onBackParentDir(){



    widget.keyword=null;
    if(widget.rootPath.compareTo(_currentPath)==0&&widget.allowPop){
      Navigator.of(context).pop();
      return Future.value(false);
    }else if(widget.rootPath.compareTo(_currentPath)!=0){
      _currentPath=PathUtils.dirname(_currentPath);
      _requestFiles();
      return Future.value(false);
    }else{
      return Future.value(false);
    }
  }


   Future<void>initState(){
     /**/
       if(widget.rootPath!=null){
         _initRootPath(widget.rootPath);
       }else{
         _initRootPath(AppConfig.instance.defaultFilesRootPath);
       }
   }

   _initRootPath(String path){

      widget.rootPath=path;
     _currentPath=path;
      _requestFiles();
   }
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text(_title,style: TextStyle(color:Colors.black),),
          backgroundColor: Color(0xffeeeeee),
          elevation: 0.0,
          leading: "/".compareTo(_currentPath)==0
              ?Container()
              :IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: _onBackParentDir,
          )
      ),
      body: widget.keyword==null
        ?SingleChildScrollView(
                padding: EdgeInsets.only(left:15,right: 15,top:10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 35,
                      child: SearchInputWidget(onTap: _onFocusSearchInput,),
                    ),
                    Center(
                      child:
                     FilesListWidget(
                         _diskFiles,
                         onFileTap: _onTapDiskFile
                     ),
                    )
                  ],
                ),
              )
          :_buildResultWidget(_resultState)
    );
  }
}
