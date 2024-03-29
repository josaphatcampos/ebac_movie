import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:pre_projeto/common/component/menu/custom_drawer_menu.dart';
import 'package:pre_projeto/common/sistem/values.dart';
import 'package:pre_projeto/home/controller/home_controller.dart';

import '../../common/component/app_bars/custom_app_bar.dart';
import '../../common/component/cards/movie_card.dart';
import '../../common/component/lists/movie_list.dart';
import '../../common/component/loading_component.dart';
import '../../common/sistem/animaitons.dart';
import '../../common/sistem/colors.dart';
import '../../common/sistem/images.dart';
import '../../common/sistem/routes.dart';

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
  void dispose() {
    _homeController.dispose();
    super.dispose();
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          externController: _homeController,
        ),
        drawer: CustomDrawerMenu(),
        body: Padding(
          padding: EdgeInsets.only(
              right: CustomValues.paddingInnerBorder,
              left: CustomValues.paddingInnerBorder),
          child: Stack(
            fit: StackFit.expand,
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
                            carouselController:
                                _homeController.carouselController,
                            options: CarouselOptions(
                              height: 270,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                _homeController.carouselPage.value = index;
                              },
                            ),
                            items: _homeController.banner.map((e) {
                              String tag = _homeController.uuid.v4();
                              return MovieCard(
                                movie: e,
                                imageUrl: e.backdropPath,
                                showBottonRatting: true,
                                showTitle: true,
                                function: () {
                                  Map<String, dynamic> params = {
                                    CustomValues.movieIdParam: e.id,
                                    CustomValues.tagParam: tag
                                  };
                                  Navigator.of(context).pushNamed(
                                      Routes.movieDetail,
                                      arguments: params);
                                },
                                tag: tag,
                              );
                            }).toList(),
                          );
                        }),
                    ValueListenableBuilder(
                      valueListenable: _homeController.carouselPage,
                      builder: (context, value, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            _homeController.banner.asMap().entries.map((e) {
                          return GestureDetector(
                            onTap: () => _homeController.carouselController
                                .animateToPage(e.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _homeController.carouselPage.value == e.key
                                  ? 16.0
                                  : 6.0,
                              height: 6.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? CustomColors.red
                                          : CustomColors.darkNavy)
                                      .withOpacity(
                                          _homeController.carouselPage.value ==
                                                  e.key
                                              ? 0.9
                                              : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _homeController.change,
                      builder: (context, value, child) => MovieList(
                        title: 'Nos cinemas',
                        catalog: _homeController.moviesInTheatre,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _homeController.change,
                      builder: (context, value, child) => MovieList(
                        title: 'Breve',
                        catalog: _homeController.upcommingMovies,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _homeController.change,
                      builder: (context, value, child) => MovieList(
                        title: 'Top',
                        catalog: _homeController.popular,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _homeController.change,
                      builder: (context, value, child) => MovieList(
                        title: 'Melhores de todos os tempos',
                        catalog: _homeController.topMovies,
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _homeController.searchterm,
                builder: (context, value, child) {
                  return
                    Stack(
                      children: [
                        Visibility(
                          visible: value.isNotEmpty,
                          child: Container(
                            color: Colors.black45,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child:
                              GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 9 / 16,
                                children: _homeController.searchMovies.movies
                                    .map((mov) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        MovieCard(
                                            imageUrl: mov.posterPath,
                                            showTitle: false,
                                            showBottonRatting: false,
                                            function: () {
                                              Map<String, dynamic> params = {
                                                CustomValues.movieIdParam:
                                                mov.id,
                                                CustomValues.tagParam:
                                                "search${mov.id}"
                                              };
                                              Navigator.of(context).pushNamed(
                                                  Routes.movieDetail,
                                                  arguments: params);
                                            },
                                            movie: mov,
                                            rounded: 8,
                                            tag: "search${mov.id}"),
                                        Text(
                                          mov.title,
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),

                            ),
                          ),
                        ),
                        Visibility(
                          visible: _homeController.searchMovies.movies.isEmpty && value.isNotEmpty,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                CustomAnimation.matrix,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              const Text(
                                "Ops. Falha na Matrix!\n não encontramos sua pesquisa.",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    ;
                },
              ),

              // ValueListenableBuilder(
              //     valueListenable: _homeController.isFindSearch,
              //     builder: (context, value, child) {
              //       return
              //       Visibility(
              //         visible: !value,
              //         child: Column(
              //           crossAxisAlignment:
              //           CrossAxisAlignment.center,
              //           children: [
              //             Lottie.asset(
              //               CustomAnimation.matrix,
              //               width: double.infinity,
              //               fit: BoxFit.contain,
              //             ),
              //             const Text(
              //               "Ops. Falha na Matrix!\n não encontramos sua pesquisa.",
              //               style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold),
              //               textAlign: TextAlign.center,
              //             ),
              //           ],
              //         ),
              //       );
              //     }),
              LoadingComponent(isLoading: _homeController.isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
