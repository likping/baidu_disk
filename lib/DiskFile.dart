//网盘文件信息数据类型
class DiskFile{
 //路径
  String path;
  //文件名
  String server_filename;
  //标识路径还是文件
  int isDir;
  //时间
  int server_ctime;
  //文件大小
  int size;
  //文件类型
  int category;
  DiskFile({
    this.path,
    this.server_filename,
    this.server_ctime,
    this.size=0,
    this.isDir=1,
    this.category=6
  });
}