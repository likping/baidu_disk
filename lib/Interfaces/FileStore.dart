import '../DiskFile.dart';
abstract class FileStore{
  /*
     [dir]下的文件列表
     [dir]以/开头的绝对路径，默认是/
     【order】排序
      time:默认->时间
      name:默认->名称
      size:默认->大小
   */
  Future<List<DiskFile>> list(String dir,{String order="name",int start=0,int limit=1000});
  Future<List<DiskFile>> search(String key,{String dir='/',int recursion=0,int page=1,int num=1000});
  static void sortFiles(List<DiskFile>files,String order){
        print(files);
  }
}