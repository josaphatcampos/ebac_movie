import 'package:shared_preferences/shared_preferences.dart';


class CustomDrawerMenuController {

  Future<bool> logout()async{
    final prefs = await SharedPreferences.getInstance();
    if(await prefs.clear()){
      return true;
    }
    return false;
  }
}