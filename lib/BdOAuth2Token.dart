import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import  "./Constant.dart";
import "./MyHomePage.dart";
import "./SharedPre_extension.dart";
import "dart:convert";
import "package:flutter_webview_plugin/flutter_webview_plugin.dart";
class BdOAuth2Token {

  String accessToken;

  ///鉴权过期时间，单位秒
  int expiresIn;

  ///鉴权创建时间,单位秒
  int createTime;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool get isExpired =>
      (createTime + expiresIn) <= DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000;

  BdOAuth2Token(this.accessToken, {this.expiresIn, this.createTime}) {
    this.createTime ??= DateTime
        .now()
        .millisecondsSinceEpoch ~/ 1000;
  }

  fromJson(Map<String, dynamic> json) {
    this.accessToken = json [' access. _token'];
    this.expiresIn = json['expires_in'];
    this.createTime = json["createTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['access_token'] = this.accessToken;
    json['expires_in'] = this.expiresIn;
    json['create_time'] = this.createTime;
    return json;
  }
  Future<bool> setJson(String key, Map<String, dynamic> json,{SharedPreferences prefs}) {
    assert(json != null);
    assert(key != null);
    var value = jsonEncode(json);
    return prefs.setString(key, value);
  }


  checkoAuth2Result(BuildContext context, String url) async {
    url = url.replaceFirst('#', '?');
    Uri uri = Uri.parse(url);
    if (uri == null) return;
    if (uri.pathSegments.contains('login_success') &&
        uri.queryParameters.containsKey('access_token')) {
      var prefs = await _prefs;
      var token = BdOAuth2Token(uri.queryParameters['access_token'],
          expiresIn: int.parse(uri.queryParameters['expires_in']));
      setJson(Constant.keyBdOAuthToken, token.toJson(),prefs:prefs,);
      print(url);
      final flutterWebviewPlugin = new FlutterWebviewPlugin();
      flutterWebviewPlugin.close();
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

}

/*
extension SharedPreferencesExtension on SharedPreferences
{

Future<bool> setJson(String key, Map<String, dynamic> json) {
  assert(json != null);
  assert(key != null);
  var value = jsonEncode(json);
  return this.setString(key, value);
}

Map<String, dynamic> getJson(String key) {
  assert(key != null);
  var value = this.getString(key);
  var json = jsonDecode(value);
  return json;
}}*/