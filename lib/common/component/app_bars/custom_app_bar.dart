import 'package:flutter/material.dart';
import 'package:pre_projeto/common/component/app_bars/controllers/custom_app_bar_controller.dart';
import 'package:pre_projeto/common/component/inputs/custom_text_search.dart';

import '../../sistem/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final CustomAppBarController _controller = CustomAppBarController();

  CustomAppBar({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      leading: IconButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: CustomColors.light),
              ))),
          onPressed: () {
            // Navigator.of(context).pop();
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu)),
      actions: [
        ValueListenableBuilder(
            valueListenable: _controller.searchWidth,
            builder: (context, value, child) => IconButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          side: BorderSide(color: CustomColors.light),
                        ))),
                onPressed: () {_controller.changeIsSearch();},
                icon: Icon(_controller.searchWidth.value > 0 ?Icons.close : Icons.search)),)
        ,
        ValueListenableBuilder(
          valueListenable: _controller.searchWidth,
          builder: (context, value, child) => AnimatedContainer(
            width: value,
            duration: Duration(milliseconds: 200),
            child: Visibility(
              visible: _controller.isSearch,
              child: CustomTextSearch(
                  controller:
                  _controller.searchController,
                  label: 'Buscar',
                  placeholder: 'Digite sua Busca'),
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
