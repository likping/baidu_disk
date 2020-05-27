import './DiskFile.dart';
import 'package:flutter/material.dart';
import  "dart:io";
class SystemFile extends DiskFile{

  SystemFile.fromSystem(FileSystemEntity file){
      FileStat fileStat=file.statSync();//取得文件数据对象-同步
      int timestamp=fileStat.modified.toLocal().millisecondsSinceEpoch~/1000;
      int isDir=FileSystemEntity.isDirectorySync(file.path)==true ?1:0;
      super.path=file.path;

      super.server_filename=file.path.substring(file.parent.path.length+1);
      super.server_ctime=timestamp;
      super.size=fileStat.size;
      super.isDir=isDir;
  }
}