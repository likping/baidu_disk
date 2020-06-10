import 'package:flutter/material.dart';
import "./BdDiskApiClient.dart";
import "./BdDiskUser.dart";
import "./BdDiskQuota.dart";
import "dart:math";
class PersonalCenter extends StatefulWidget{
  final BdDiskApiClient apiClient=BdDiskApiClient();
  State createState(){
    return  _PersonalCenterState();
  }
}
class _PersonalCenterState extends State<PersonalCenter>{
  //个人头像+进度条
  BdDiskUser userInfo;
  BdDiskQuota quota;
  _resquestUserInfo()async{

       widget.apiClient.getUserInfo().then((e){
            setState(() {
              userInfo=e;
            });
       });
       widget.apiClient.getDiskQuota().then((e){
           setState(() {
             print(e);
             quota=e;
           });
       });
  }
  initState(){
    _resquestUserInfo();
  }
  Widget _PersonalWidget(){
    return new Container(
        height:75,
        padding: EdgeInsets.only(left: 20,top: 25),
        child:new Row(
          children: <Widget>[
            userInfo==null
                ?Image.asset("assets/swan_app_user_portrait_pressed.png")
                :Image.network(userInfo.avatarUrl),
            new Expanded(
                child:  new Column(children: <Widget>[
                  new Row(children:<Widget>[
                    Text( userInfo==null?"xxxx":userInfo.baiduName),
                    new SizedBox(
                      height: 20,
                      child: Image.asset("assets/home_identity_common.png"),
                    )

                  ]),
                  new SizedBox(
                    height: 10.0,
                    width: 288,
                    child: new ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(10.0)),
                      child:new LinearProgressIndicator(
                        value:(quota.ratio),
                        backgroundColor:Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                  new Text("${(quota.used/pow(2,30)).floor()}/${(quota.total/pow(2,30)).floor()} G")


                ],
                ))

          ],
        ));
  }
  //网络视图分格
  Widget _NetViewGridWidget(){
    return new Container(
      height: 300,
      child:  new Center(
          child:new GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8
            ),
            children: <Widget>[
              _GridImageWidget(url:"assets/file_add_btn_scan.png",title:"扫一扫"),
              _GridImageWidget(url:"assets/file_add_btn_photo.png",title:"上传照片"),
              _GridImageWidget(url:"assets/file_add_btn_video.png",title:"上传视频"),
              _GridImageWidget(url:"assets/file_add_btn_note.png",title:"上传笔记"),
              _GridImageWidget(url:"assets/file_add_btn_file.png",title:"上传文档"),
              _GridImageWidget(url:"assets/file_add_btn_music.png",title:"上传音乐"),
              _GridImageWidget(url:"assets/file_add_btn_folder.png",title:"上传文件夹"),
              _GridImageWidget(url:"assets/file_add_btn_other.png",title:"上传其他文件"),
            ],
          )

      ),
    );
  }
  //图片+文字Widget组件方法，以便复用。
  Widget _GridImageWidget({String url, String title}){
    return  new SizedBox(
        child:new Column(
            children:<Widget>[
              Image.asset(url),
              new Text(title)
            ])
    );
  }
  //整合所有Widget
  Widget build(BuildContext context){
    return new Material(
      child: new Column(
        children: <Widget>[
          _PersonalWidget(),
          _NetViewGridWidget(),
        ],
      ),
    );
  }
}
