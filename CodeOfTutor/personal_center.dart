import 'package:flutter/material.dart';

class PersonalCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _gridViewItems = const [
    ['扫一扫', 'assets/file_add_btn_scan.png'],
    ['上传照片', 'assets/file_add_btn_photo.png'],
    ['上传视频', 'assets/file_add_btn_video.png'],
    ['新建笔记', 'assets/file_add_btn_note.png'],
    ['上传文档', 'assets/file_add_btn_file.png'],
    ['上传音乐', 'assets/file_add_btn_music.png'],
    ['新建文件夹', 'assets/file_add_btn_folder.png'],
    ['上传其它文件', 'assets/file_add_btn_other.png']
  ];

  int _userVipLevel = 0;

  Widget _buildGridViewItem(String title, String imageName) {
    return Column(
      children: <Widget>[
        Image.asset(
          imageName,
          width: 50,
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 40),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: Image.asset('assets/user-head.jpg',
                      width: 64, height: 64, fit: BoxFit.cover),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '移动开发',
                            style: _normalFont,
                          ),
                          Image.asset('assets/user-level$_userVipLevel.png',
                              height: 20, width: 20),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                        child: LinearProgressIndicator(
                          value: 0.3,
                          backgroundColor: Colors.black12,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      Text(
                        '668GB/3320GB',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Expanded(
              child: GridView.builder(
                itemCount: _gridViewItems.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildGridViewItem(
                        _gridViewItems[index][0], _gridViewItems[index][1]),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, //横轴元素个数
                  mainAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfo {
  /**
   * 百度账号
   */
  String baiduName;

  /**
   * 网盘账号
   */
  String netdiskame;

  /**
   * 头像地址
   */
  String avatarUrl;

  /**
   * 会员类型，0普通用户、1普通会员、2超级会员
   */
  int vipType;

  /**
   * 用户ID
   */
  int uk;
}

class DiskQuota {
  /**
   * 总空间大小，单位B
   */
  int total;

  /**
   * 7天内是否有容量到期
   */
  bool expire;

  /**
   * 已使用大小，单位B
   */
  int used;

  /**
   * 剩余大小，单位B
   */
  int free;
}
