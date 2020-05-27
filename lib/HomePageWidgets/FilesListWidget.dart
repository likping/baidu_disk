import '../DiskFile.dart';
import 'package:flutter/material.dart';
import '../Utils.dart';
//文件列表组件
class FilesListWidget extends StatelessWidget {
  var diskFiles = List<DiskFile>();
  FilesListOnFileTapCallback onFileTap;

  FilesListWidget(this.diskFiles, {this.onFileTap});
  // 实现文件控件
  Widget _buildFileItem(DiskFile file){
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5,color:Color(0xffe5e5e5)))
        ),
        child: ListTile(
          leading: Image.asset(("assets/file.png")),
          title:Text(file.server_filename),
          subtitle: Text("${Utils.getDateTime(file.server_ctime)},${Utils.getFileSize(file.size)}"),
        ),
      ),
      onTap: (){
        if(null!=this.onFileTap) this.onFileTap(file);
      },
    );
  }
  //文件夹
  Widget _buildFolderItem(DiskFile file){
    //去掉水波纹效果
    return InkWell(
      child: Container(
//          排成直线
          alignment:Alignment.center,
          decoration: BoxDecoration(
            //T边框的侧
              border: Border(bottom: BorderSide(width: 0.5,color:Color(0xffe5e5e5)))

          ),
          //列表片
          child:ListTile(
            leading:Image.asset("assets/ic_gc_main_empty_folder.png"),
            title: Row(
              children: <Widget>[
                Expanded(child: Text(file.server_filename),)
              ],
            ),
            //子标题
            subtitle: Text(Utils.getDateTime(file.server_ctime)),
            trailing: Icon(Icons.chevron_right),
          )
      ),
      onTap: (){
        //
        if(null !=this.onFileTap) this.onFileTap(file);
      },
    );
  }
  //实际构造
  Widget _buildFilesWidget() =>
      this.diskFiles==null||this.diskFiles.length == 0
          ? Column(
        //无文件就显示空文件
        children: <Widget>[
             SizedBox(height: 200,),
             Image.asset("assets/ic_gc_main_empty_folder.png"),
             Text("当前目录下无文件")
        ],

      )
      //存在文件就出现列表控件
          :ListView.builder(
        //物理滑块
        physics: BouncingScrollPhysics(),
        //shrink--收缩
        //Wrap--包裹
        shrinkWrap: true,
        itemCount: this.diskFiles.length,//元素个数
        itemBuilder: (BuildContext context,int index){//遍历每个文件信息创建相应的显示图片
          if(this.diskFiles[index].isDir==0){//不是文件夹
            return _buildFileItem(this.diskFiles[index]);
          }else{
            return _buildFolderItem(this.diskFiles[index]);//是文件夹就创建文件夹
          }
        },
      );

  Widget build(BuildContext build)=>_buildFilesWidget();

}
typedef FilesListOnFileTapCallback =void Function(DiskFile file);
