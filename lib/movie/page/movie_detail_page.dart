import 'package:flutter/material.dart';
import 'package:pre_projeto/common/component/app_bars/custom_inner_app_bar.dart';

import '../../common/component/app_bars/custom_app_bar.dart';
import '../../common/sistem/colors.dart';
import '../../common/sistem/images.dart';
class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {

    final String args = ModalRoute.of(context)!.settings.arguments as String;

    return Container(
      decoration: const BoxDecoration(
          color: CustomColors.darkNavy,
          image: DecorationImage(
              image: AssetImage(CustomImages.loginBg), fit: BoxFit.cover),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors.black,
                CustomColors.lightNavy,
                CustomColors.lightNavy,
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomInnerAppBar(title: args,),
        body: Stack(),
      ),
    );
  }
}
