import 'dart:io';
import "./AppConfig.dart";
import  "./BdDiskUser.dart";
import "./BdDiskQuota.dart";
import "./BdDiskFile.dart";
import "dart:convert";
class BdDiskApiClient{
  final HttpClient httpClient;
  final protocal="https";
  final host="pan.baidu.com";
  final userInfoPath="/rest/2.0/xpan/nas";
  final diskQuotaPath="/api/quota";
  final diskFilePath="/rest/2.0/xpan/file";
   get accessToken async{

    var token=  AppConfig.instance.token();

    return token;
  }
  BdDiskApiClient({HttpClient httpClient}):this.httpClient=httpClient??HttpClient();

  Future<List<BdDiskFile>>getSearchFile(String key,{
    String dir="/",
    int page=1,
    int num=1000,
    String recursion="0",//0不递归，1递归
    String web=""
})async{
    HttpClientRequest request=await httpClient.getUrl(Uri.https(
        host,
        diskFilePath,
        {
          "method":"search",
          "access_token":"${await accessToken}",
          "web":web,
          "key":"$key",
          "recursion":recursion,
        }
    ));
    HttpClientResponse response=await request.close();
    var responseBody=await response.transform(Utf8Decoder()).join();

    var json=jsonDecode(responseBody);

    if(json["errno"]!=0)
      throw Exception("ERROR CODE ${json["errno"]}");
    var list=(json["list"] as List<dynamic>);

    return list.map((f)=>BdDiskFile.fromJson(f)).toList();
  }
  Future<BdDiskUser> getUserInfo()async{
    HttpClientRequest request=await httpClient.getUrl(
      Uri.https(
        host,
        userInfoPath,
        {"method":"uinfo","access_token":"${await accessToken}"}
      )
    );
    HttpClientResponse response =await request.close();

    var responseBody=await response.transform(Utf8Decoder()).join();
    var json=jsonDecode(responseBody);
    return BdDiskUser.fromJson(json);
  }
  Future<BdDiskQuota> getDiskQuota()async{
    HttpClientRequest request=await httpClient.getUrl(Uri.https(
      host,
      diskQuotaPath,
      {"access_token":"${await accessToken}"}
      ));
    HttpClientResponse response=await request.close();
    var responsBody=await response.transform(Utf8Decoder()).join();
    var json=jsonDecode(responsBody);
    return BdDiskQuota.fromJson(json);
  }
  Future<List<BdDiskFile>>getListFile(String dir,{
    String order="name",
    int start=0,
    int limit=1000,
    String desc="0",
    String web="",
    int folder=0,
    int showempty=1
  })async{
      HttpClientRequest request=await httpClient.getUrl(Uri.https(
        host,
        diskFilePath,
        {
         "method":"list",
         "access_token":"${await accessToken}",
         "dir":"$dir",
         "order":"$order",
         "start":"$start",
         "limit":"$limit",
         "desc":desc,
         "web":web,
         "folder":"$folder",
         "showempty":"$showempty"
        }
      ));
      HttpClientResponse response=await request.close();
      var responseBody=await response.transform(Utf8Decoder()).join();

      var json=jsonDecode(responseBody);

      if(json["errno"]!=0)
         throw Exception("ERROR CODE ${json["errno"]}");
      var list=(json["list"] as List<dynamic>);

      return list.map((f)=>BdDiskFile.fromJson(f)).toList();
  }
}