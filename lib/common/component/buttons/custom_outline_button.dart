import 'package:flutter/material.dart';

import '../../sistem/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color bordercolor;
  final Color textColor;

  const CustomOutlineButton({super.key, required this.title, required this.onPressed, this.bordercolor = CustomColors.light, this.textColor = CustomColors.light});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      side: BorderSide(color: bordercolor)
                  )
              )
          ),
          onPressed: onPressed, child: Container(
        child: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 14),),
      )),
    );
  }
}

