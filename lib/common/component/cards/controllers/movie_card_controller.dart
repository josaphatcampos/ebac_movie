import 'package:flutter/cupertino.dart';

class MovieCardController{
  ValueNotifier<bool> animate = ValueNotifier<bool>(false);

  MovieCardController(){
    showAnimated();
  }

  void showAnimated(){
    Future.delayed(const Duration(seconds: 1), () => animate.value = true,);
  }
}