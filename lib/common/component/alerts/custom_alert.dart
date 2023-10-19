
import 'package:flutter/material.dart';
import 'package:pre_projeto/common/component/buttons/custom_outline_button.dart';
import 'package:pre_projeto/common/sistem/colors.dart';

class CustomAlert{

  CustomAlert._();


  static showMessage(BuildContext context, String message){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Icon(Icons.warning, color: CustomColors.yellow,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message,style: const TextStyle(color: CustomColors.light, fontSize: 18),),
        ],
      ),
      backgroundColor: CustomColors.darkNavy,
      actions: [
        CustomOutlineButton(title: 'Ok', onPressed: (){Navigator.of(context).pop();},)
      ],
    ),);
  }
  static errorMessage(BuildContext context, String message){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Icon(Icons.block, color: CustomColors.red,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message,style: const TextStyle(color: CustomColors.light, fontSize: 18),),
        ],
      ),
      backgroundColor: CustomColors.darkNavy,
      actions: [
        CustomOutlineButton(title: 'Ok', onPressed: (){Navigator.of(context).pop();}, bordercolor: CustomColors.red, textColor: CustomColors.red,)
      ],
    ),);
  }

}
