import 'package:flutter/material.dart';
import 'package:pre_projeto/common/component/menu/controller/custom_drawer_menu_controller.dart';
import 'package:pre_projeto/common/sistem/images.dart';
import 'package:pre_projeto/common/sistem/routes.dart';
import 'package:pre_projeto/common/sistem/utils.dart';
import 'package:pre_projeto/common/sistem/values.dart';

import '../../sistem/colors.dart';

class CustomDrawerMenu extends StatelessWidget {
  CustomDrawerMenu({super.key});

  final CustomDrawerMenuController _controller = CustomDrawerMenuController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          width: double.infinity,
          color: CustomColors.darkNavy,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(CustomImages.menuBg),
                        fit: BoxFit.cover,
                        opacity: 0.15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset(CustomImages.logo),
                        ),
                        SizedBox(width: CustomValues.marginComponent),
                        Column(
                          children: [
                            const Text("Bem vindo, "),
                            Text(Utils.globalUser!.firstName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Sair"),
                onTap: () async {
                  if (await _controller.logout()) {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  }
                },
              )
            ],
          )),
    );
  }
}
