import 'package:flutter/material.dart';

import '../../sistem/colors.dart';
class CustomIconOutlineButton extends StatelessWidget {

  final IconData iconData;
  final Function function;
  final double iconPadding;
  final double iconSIze;
  final double iconRound;

  const CustomIconOutlineButton({
    super.key, required this.iconData, required this.function, this.iconPadding = 5, this.iconSIze = 24, this.iconRound = 16
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                 EdgeInsets.all(iconPadding)
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                 RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(iconRound)),
                  side: const BorderSide(color: CustomColors.light),
                )
            )
        ),
        onPressed: ()=>function, icon:  Icon(iconData, size: iconSIze,)
    );
  }
}