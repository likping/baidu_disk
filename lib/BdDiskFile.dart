import "./DiskFile.dart";
import "./Thumbs.dart";
class BdDiskFile extends DiskFile{
      int serverMtime;
      int unlist;
      int fsId;
      int operId;
      int serverCtime;
      int localMtime;
      Thumbs thumbs;
      int  share;
      String md5;
      int localCtime;
      BdDiskFile({
        this.serverCtime,
        this.unlist,
        this.fsId,
        this.operId,
        this.serverMtime,
        this.localMtime,
        this.thumbs,
        this.share,
        this.md5,
        this.localCtime
      });
    BdDiskFile.fromJson(Map<String,dynamic>json):super.fromJson(json){
          serverMtime=json["server_mtime"];
          unlist=json["unlist"];
          fsId=json["fs_id"];
          operId=json["oper_id"];
          serverCtime=json["server_ctime"];
          localMtime=json["local_mtime"];
          thumbs=json["thumbs"]!=null ?new Thumbs().fromJson(json["thumb"]):null;
          share=json["share"];
          md5=json["md5"];
          localCtime=json["local_ctime"];
    }
    Map<String,dynamic>toJson(){
         final Map<String,dynamic>data=super.toJson();
         data["server_mtime"]=this.serverMtime;
         data["unlist"]=this.unlist;
         data["fs_id"]=this.fsId;
         data["operId"]=this.operId;
         data["server_ctime"]=this.serverCtime;
         data["local_mtime"]=this.localMtime;
         if(this.thumbs!=null){
           data["thumbs"]=this.thumbs.toJson();
         }
         data["share"]=this.share;
         data["md5"]=this.md5;
         data["local_ctime"]=this.localCtime;
         return data;
    }
}
