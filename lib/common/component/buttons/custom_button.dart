import 'package:flutter/material.dart';

import '../../sistem/colors.dart';
import '../../sistem/images.dart';
class CustomButton extends StatelessWidget {

  final String title;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;

  const CustomButton({super.key, required this.title, required this.onPressed, this.color = CustomColors.red, this.textColor = CustomColors.light, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                  )
              )
          ),
          onPressed: onPressed, child: Container(
        child: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 14),),
      )),
    );
  }
}
