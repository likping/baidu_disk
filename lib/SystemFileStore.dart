import './Interfaces/FileStore.dart';
import './DiskFile.dart';
import "dart:io";
import './PathUtils.dart';
//import './Completer.dart';
import './AppConfig.dart';
import './SystemFile.dart';
import "dart:async";
class SystemFileStore implements FileStore{
  Future<List<DiskFile>> list(String dir,{String order="name",int start=0,int limit=1000}) async {

      var diskFiles=List<DiskFile>();
      if(null==dir){
        return diskFiles;
      };
      Directory directory=Directory(dir);
      int count=0;
      var _diskFilesComplete=Completer();
      var listOfFiles=directory.list(followLinks: false);

      listOfFiles.listen(((file){

      var fileName=PathUtils.basename(file.path);
         if(file.path==null||
            (fileName.substring(0,1)=='.'&&
                !AppConfig.instance.showAllFiles)
            ||count++<start) return  ;
        if(count>(start+limit)){
          _diskFilesComplete.isCompleted
              ?null
              :_diskFilesComplete.complete("");
          return;
        }
       diskFiles.add(SystemFile.fromSystem(file));
      }),
      onDone: ()=>_diskFilesComplete.isCompleted
          ?null:
      _diskFilesComplete.complete(""),
          onError: (e)=>_diskFilesComplete.completeError(e)
      );
      await _diskFilesComplete.future;
      FileStore.sortFiles(diskFiles, order);
      return diskFiles;
  }
  /*todo 递归寻找关键字出现一些问题，应该是迭代异步问题*/
   void SearchFiles(file,int count,int start,int num,Completer _diskFileComplete,String key,List<DiskFile> diskFiles)async{
     var fileName=PathUtils.basename(file.path);
     /*
     if(file.path!=null&&(fileName.substring(0,1)!=".")&&!fileName.contains(".")&&!fileName.toLowerCase().contains(key.toLowerCase())){
         Directory directory=Directory(file.path);
         var listOfFiles=directory.list(recursive:false);
         var _diskFileComplete=Completer();
         listOfFiles.listen(
             ((file){
               SearchFiles(file, count, start, num, _diskFileComplete, key, diskFiles);
             }),
             onDone: ()=>_diskFileComplete.isCompleted
                 ?null
                 :_diskFileComplete.complete(""),
             onError: (e)=>_diskFileComplete.completeError(e)
         );
         await _diskFileComplete.future;
     }
     */
     if(file.path==null||(fileName.substring(0,1)==".")|| !fileName.toLowerCase().contains(key.toLowerCase())||
         count++<start
     ) return;
     if(count>(start+num)){
       _diskFileComplete.isCompleted
           ?null
           :_diskFileComplete.complete("");
       return;
     }
     diskFiles.add(SystemFile.fromSystem(file));
   }
  Future<List<DiskFile>> search(String key,{String dir="/storage/emulated/0",int recursion=0,int page=1,int num=1000})async{

    var diskFiles=List<DiskFile>();
    int count=0;
    int start=(page-1)*num;
    Directory directory=Directory(dir);
    var listOfFiles=directory.list(recursive: recursion==1?true:false);
    var _diskFileComplete=Completer();
    listOfFiles.listen(
        ((file){
          SearchFiles(file, count, start, num, _diskFileComplete, key, diskFiles);
        }),
      onDone: ()=>_diskFileComplete.isCompleted
        ?null
          :_diskFileComplete.complete(""),
      onError: (e)=>_diskFileComplete.completeError(e)
    );
    await _diskFileComplete.future;
    return diskFiles;
  }

}