import 'package:baidu_disk/DiskFile.dart';
final s=[
  DiskFile(
    path: '/实验室一',
    server_filename: '实验一' ,
//    server_ctime: Utils.currentTimeSeconds(),
  ),
  DiskFile(
    path: ' /实验室二' ,
    server_filename: '实验二 ',
//    server_ctime: Utils.currentTimeSeconds(),
  ),
  DiskFile(
    path: '/实验室三',
    server_filename: ' 实验三E ' ,
//    server_ctime: Utils.currentTimeSeconds(),
  ),
  DiskFile(
      path: '/第- -讲. pptx',
      server_filename: '第- -讲。pptx',
//      server_ctime: Utils.currentTimeSeconds(),
      isDir: 0,
      category: 4,
      size: 989
  ),
  DiskFile(
      path:'/第二讲 。pptx',
      server_filename: '第二讲 。pptx',
//      server_ctime:Utils.currentTimeSeconds(),
      isDir: 0,
      category: 4,
      size: 9839)
];
final  _subPathFilesDir=[
  DiskFile(
    path: '/实验室- - /源代码',
    server_filename: ' 源代码' ,
//    server_ctime: Utils. currentTimeSeconds(),
  ),
  DiskFile(
      path: '/实验室- ./实验指导书.pdf',
      server_filename: '实验指导书 .pdf',
//      server_ctime: Utils. currentTimeSeconds(),
      isDir: 0,
      category: 4,
      size: 983),
];