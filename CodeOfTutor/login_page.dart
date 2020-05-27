import 'main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _biggerFont =
      const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);

  String _accountText = '';
  String _pwdText = '';
  bool _isEnableLogin = false;
  bool _obscureText = true;

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     * 3、请思考如何解决当允许登录状态改变时，不重绘整个LoginPage，而是局部发生重绘优化性能，
     *    在后期复杂场景下有助于性能提升。
     */
    if (_accountText.isNotEmpty && _pwdText.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  _getLoginButtonPressed() {
    if (!_isEnableLogin) return null;

    return () {
      showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text('登录提醒'),
              content: Text('登录账户：$_accountText \n'
                  '登录密码：$_pwdText'),
              actions: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: Text(
                    '确 认',
                    style: _normalFont,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                FlatButton(
                  color: Colors.blue,
                  child: Text(
                    '取 消',
                    style: _normalFont,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    };
  }

  Widget _buildTopWidget() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/baiduLogo.png'),
          Text(
            '欢迎登陆百度账户',
            style: _biggerFont,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountEditTextField() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: TextField(
        onChanged: (text) {
          _accountText = text;
          _checkUserInput();
        },
        style: _normalFont,
        decoration: InputDecoration(
          hintText: '请输入手机号/用户名/邮箱',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: _borderRadius),
        ),
      ),
    );
  }

  Widget _buildPwdEditTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        onChanged: (text) {
          _pwdText = text;
          _checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText,
        decoration: InputDecoration(
            hintText: '请输入登陆密码',
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText = !_obscureText),
              icon: Image.asset(
                _obscureText ? 'assets/closeEye.png' : 'assets/openEye.png',
                width: 20,
                height: 20,
              ),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            )),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        child: Text("登 录", style: _normalFont),
        color: Colors.blue,
        disabledColor: Colors.black12,
        textColor: Colors.white,
        disabledTextColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        onPressed: _getLoginButtonPressed(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopWidget(),
            _buildAccountEditTextField(),
            _buildPwdEditTextField(),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }
}
