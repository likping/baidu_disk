import "./BdDiskApiClient.dart";
import"package:shared_preferences/shared_preferences.dart";
import "./BdDiskUser.dart";
import "./Constant.dart";
import "dart:convert";
class UserRepository{
  final BdDiskApiClient apiClient;
  Future<SharedPreferences>_prefs=SharedPreferences.getInstance();
  UserRepository({BdDiskApiClient apiClient}):this.apiClient=apiClient ?? BdDiskApiClient();

  Future<BdDiskUser> getUserInfo() async{
    BdDiskUser user;
    var prefs=await _prefs;
    try{
      user =await apiClient.getUserInfo();

    }catch(e){

      if(SharedPre_constainKey(Constant.keyUserInfo))
        return BdDiskUser.fromJson(SharedPre_getJson(Constant.keyUserInfo));
      return null;

    }
    SharedPre_setJson(Constant.keyUserInfo,user.toJson(),p:prefs);

    return user;
  }
  /*以下三个函数是我位dart2.4做的适配函数*/
  /*dart2.4 不支持extension的语法*/
  Future<bool> SharedPre_setJson(String key, Map<String, dynamic> json,{SharedPreferences p}) {
    assert(json != null);
    assert(key != null);
    var value = jsonEncode(json);
    return p.setString(key, value);
  }

  Map<String, dynamic> SharedPre_getJson(String key,{SharedPreferences p}) {
    assert(key != null);
    var value = p.getString(key);
    var json = jsonDecode(value);
    return json;
  }
  bool SharedPre_constainKey(String key,{SharedPreferences p}){
    var set=p.getKeys();
    if(set.contains(key)){
      return true;
    }else{
      return false;
    }
  }
}

