import "dart:math";
class BdDiskQuota{
  int errno;
  num used;
  num total;
  num requestId;
  num  ratio;
  BdDiskQuota.fromJson(json){
        errno=json["errno"];
        used=json["used"];
        total=json["total"];
        requestId=json["request_id"];
        ratio= used/total;
  }
}