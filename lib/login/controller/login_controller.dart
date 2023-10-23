
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pre_projeto/common/model/user_model.dart';
import 'package:pre_projeto/common/services/repositories/login_repository.dart';
import 'package:pre_projeto/common/sistem/utils.dart';
import 'package:pre_projeto/common/sistem/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController{
   final LoginRepository _loginRepository = LoginRepository();
   late AnimationController animationController;

   TextEditingController usercontroller = TextEditingController();
   TextEditingController passcontroller = TextEditingController();

   ValueNotifier<bool> isEnableLogin = ValueNotifier<bool>(false);
   ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

   LoginController(){
      usercontroller.addListener(() { _enableLogin();});
      passcontroller.addListener(() { _enableLogin();});
   }

   void dispose(){
      animationController.dispose();
      usercontroller.dispose();
      passcontroller.dispose();
   }

   void _enableLogin(){
      isEnableLogin.value = usercontroller.text.isNotEmpty && passcontroller.text.isNotEmpty;
   }

   Future<bool> tryLogin() async {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 5));
      isLoading.value = false;

      try{
         Map<String,dynamic> user = _loginRepository.getLogin(usercontroller.text, passcontroller.text);
         return _saveLocalData(user);
      }catch (e){
         return false;
      }
   }

   Future<bool> getKeepLogged() async {
      isLoading.value = true;
      bool isUSer = await Utils.checkAlreadyLogged();
      isLoading.value = false;
      return isUSer;
   }

   Future<bool> _saveLocalData(Map<String, dynamic> user)async{
      final prefs = await SharedPreferences.getInstance();
      try{
         prefs.setString(CustomValues.userkey, jsonEncode(user));
         return true;
      }catch(e){
         return false;
      }

   }


}