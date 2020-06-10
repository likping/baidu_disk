import "package:shared_preferences/shared_preferences.dart";
import './Constant.dart';
import "dart:convert";
class AppConfig{
    bool showAllFiles=true;
//    String defaultFilesRootPath="/storage/emulated/0";
    String defaultFilesRootPath="/";
    static  AppConfig instance=AppConfig();
    Future<String> token()async {
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        var prefs=await _prefs;
        var info=jsonDecode(prefs.getString(Constant.keyBdOAuthToken));
        return Future.value(info["access_token"]);
    }

}
