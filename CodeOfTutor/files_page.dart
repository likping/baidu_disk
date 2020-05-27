import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'files_list.dart';
import 'search_input.dart';
import 'search_page.dart';
import 'utils.dart';

class FilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  final _rootPathFilesDir = [
    DiskFile(
      path: '/实验室一',
      server_filename: '实验一',
      server_ctime: Utils.currentTimeSeconds(),
    ),
    DiskFile(
      path: '/实验室二',
      server_filename: '实验二',
      server_ctime: Utils.currentTimeSeconds(),
    ),
    DiskFile(
      path: '/实验室三',
      server_filename: '实验三',
      server_ctime: Utils.currentTimeSeconds(),
    ),
    DiskFile(
        path: '/第一讲.pptx',
        server_filename: '第一讲.pptx',
        server_ctime: Utils.currentTimeSeconds(),
        isdir: 0,
        category: 4,
        size: 989),
    DiskFile(
        path: '/第二讲.pptx',
        server_filename: '第二讲.pptx',
        server_ctime: Utils.currentTimeSeconds(),
        isdir: 0,
        category: 4,
        size: 9839),
  ];

  final _subPathFilesDir = [
    DiskFile(
      path: '/实验室一/源代码',
      server_filename: '源代码',
      server_ctime: Utils.currentTimeSeconds(),
    ),
    DiskFile(
        path: '/实验室一/实验指导书.pdf',
        server_filename: '实验指导书.pdf',
        server_ctime: Utils.currentTimeSeconds(),
        isdir: 0,
        category: 4,
        size: 983),
  ];

  final _emptyDir = List<DiskFile>();

  var _diskFiles = [];

  String _title = '根目录';

  String _currPath = '/';

  @override
  void initState() {
    _currPath = '/';
    _diskFiles = _rootPathFilesDir;
  }

  /// 更新当前路径下的所有文件数据信息，
  /// 后期可以扩展网络或者本地更新文件信息;
  /// 以下代码仅针对模拟的文件数据有效
  void _refreshFiles() {
    setState(() {
      int index = _currPath.lastIndexOf('/');

      if (_currPath.length == 1) _diskFiles = _rootPathFilesDir;

      if (_currPath.length > 1) _diskFiles = _subPathFilesDir;

      if (index > 0) _diskFiles = _emptyDir;
    });
  }

  Future<bool> _onBackParentDir() {
    _currPath = Utils.getParentPath(_currPath);
    _title = Utils.getCurrPathFileName(_currPath);

    _refreshFiles();

    return Future.value(false);
  }

  void _onTapDiskFile(DiskFile file) {
    if (0 == file.isdir) return;

    _title = file.server_filename;
    _currPath = file.path;

    _refreshFiles();
  }

  void _onFocusSearchInput() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xffeeeeee),
        elevation: 0.0,
        leading: '/'.compareTo(_currPath) == 0
            ? Container()
            : IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.black),
                onPressed: _onBackParentDir),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: <Widget>[
            Container(
                height: 35,
                child: SearchInputWidget(onTap: _onFocusSearchInput)),
            Center(
                child: FilesListWidget(_diskFiles, onFileTap: _onTapDiskFile)),
          ],
        ),
      ),
    );
  }
}
