import 'package:flutter/material.dart';

import '../../sistem/colors.dart';
class CustomInnerAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const CustomInnerAppBar({
    super.key, this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      leading:IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    side: BorderSide(color: CustomColors.light),
                  )
              )
          ),
          onPressed: (){
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.chevron_left)
      ),
      actions: [
        IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      side: BorderSide(color: CustomColors.light),
                    )
                )
            ),
            onPressed: (){}, icon: const Icon(Icons.search)
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>Size.fromHeight(60);
}