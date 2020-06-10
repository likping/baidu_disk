class Thumbs {
    fromJson(Map<String,dynamic>json){
          icon=json["icon"];
          url1=json["url1"];
          url2=json["url2"];
          url3=json["url3"];
     }
     Map<String,dynamic>toJson(){
          final Map<String,dynamic>data=new Map<String,dynamic>();
          data["icon"]=this.icon;
          data["url3"]=this.url3;
          data["url2"]=this.url2;
          data["url1"]=this.url1;
          return data;
     }
     String icon;
     String url3;
     String url2;
     String url1;
     Thumbs({this.icon,this.url3,this.url1});

}