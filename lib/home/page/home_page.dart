import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pre_projeto/common/sistem/values.dart';
import 'package:pre_projeto/home/controller/home_controller.dart';

import '../../common/component/app_bars/custom_app_bar.dart';
import '../../common/component/cards/movie_card.dart';
import '../../common/component/lists/movie_list.dart';
import '../../common/component/loading_component.dart';
import '../../common/sistem/colors.dart';
import '../../common/sistem/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController = HomeController();
  }

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: EdgeInsets.only(
            right: CustomValues.paddingInnerBorder,
            left: CustomValues.paddingInnerBorder - 4),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: CustomValues.paddingInnerBorder,
                    ),




                    ValueListenableBuilder(
                        valueListenable: _homeController.isLoading,
                        builder: (context, value, child) {
                          return CarouselSlider(
                            carouselController: _homeController.carouselController,
                            options: CarouselOptions(
                              height: 270,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                _homeController.carouselPage.value = index;
                              },
                            ),
                            items: _homeController.banner.map((e){
                              return MovieCard(
                                movie: e,
                                imageUrl:
                                e.backdropPath,
                                showBottonRatting: true,
                                showTitle: true,
                                function: () {
                                  print("dassa");
                                },
                              );
                            }).toList(),
                          );
                        }),
                    ValueListenableBuilder(valueListenable: _homeController.carouselPage, builder:(context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _homeController.banner.asMap().entries.map((e){
                        return GestureDetector(
                          onTap: ()=>_homeController.carouselController.animateToPage(e.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                    .withOpacity(_homeController.carouselPage.value == e.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),),

                    const SizedBox(
                      height: 48,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _homeController.isLoading,
                      builder: (context, value, child) => MovieList(
                          title: 'Popular', catalog: _homeController.popular),
                    ),
                  ],
                ),
              ),
              LoadingComponent(isLoading: _homeController.isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
