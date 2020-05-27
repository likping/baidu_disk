import 'package:flutter/material.dart';

import 'utils.dart';

class DiskFile {
  /// 文件的绝对路径
  String path;

  ///文件名称
  String server_filename;

  /// 是否目录，0 文件、1 目录
  int isdir;

  /// 文件在服务器修改时间
  int server_ctime;

  /// 文件大小，单位B
  int size;

  /// 文件类型，1 视频、2 音频、3 图片、4 文档、5 应用、6 其他、7 种子
  int category;

  DiskFile({
    this.path,
    this.server_filename,
    this.server_ctime,
    this.size = 0,
    this.isdir = 1,
    this.category = 6,
  });
}

typedef FilesListOnFileTapCallback = void Function(DiskFile file);

class FilesListWidget extends StatelessWidget {
  var diskFiles = List<DiskFile>();

  FilesListOnFileTapCallback onFileTap;

  FilesListWidget(this.diskFiles, {this.onFileTap});

  @override
  Widget build(BuildContext context) => _buildFilesWidget();

  Widget _buildFilesWidget() => this.diskFiles.length == 0
      ? Column(
          children: <Widget>[
            SizedBox(height: 200),
            Image.asset('assets/folder.png'),
            Text('当前目录下没有文件')
          ],
        )
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: this.diskFiles.length,
          itemBuilder: (BuildContext context, int index) {
            if (this.diskFiles[index].isdir == 0)
              return _buildFileItem(this.diskFiles[index]);
            else
              return _buildFolderItem(this.diskFiles[index]);
          },
        );

  Widget _buildFolderItem(DiskFile file) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/folder.png'),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(file.server_filename)),
            ],
          ),
          subtitle: Text(Utils.getDateTime(file.server_ctime)),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        if (null != this.onFileTap) this.onFileTap(file);
      },
    );
  }

  Widget _buildFileItem(DiskFile file) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/file.png'),
          title: Text(file.server_filename),
          subtitle: Text('${Utils.getDateTime(file.server_ctime)}  '
              '${Utils.getFileSize(file.size)}'),
        ),
      ),
      onTap: () {
        if (null != this.onFileTap) this.onFileTap(file);
      },
    );
  }
}
