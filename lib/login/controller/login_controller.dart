
import 'package:flutter/cupertino.dart';

class LoginController{
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
      if(usercontroller.text == 'jocampos' && passcontroller.text == '123'){
         return true;
      }

      return false;
   }

}