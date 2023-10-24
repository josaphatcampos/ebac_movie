import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pre_projeto/common/component/cards/controllers/movie_card_controller.dart';
import 'package:pre_projeto/common/model/movie_model.dart';
import 'package:pre_projeto/common/sistem/utils.dart';
import '../../sistem/colors.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final bool showTitle;
  final bool showBottonRatting;
  final double height;
  final double width;
  final double rounded;
  final Function function;
  final Movie movie;
  final String tag;

  MovieCardController _movieCardController = MovieCardController();

  MovieCard({super.key,
    required this.imageUrl,
    required this.showTitle,
    required this.showBottonRatting,
    this.height = 270,
    this.width = double.infinity,
    this.rounded = 32.0,
    required this.function,
    required this.movie, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(rounded)),
        child: Hero(
          tag: tag,
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: CustomColors.lightNavy,
                  image: DecorationImage(
                      image: NetworkImage('${Utils.movieApiImageUrl}$imageUrl'),
                      fit: BoxFit.cover)),
              child: Stack(
                  children: [
              Container(
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CustomColors.black,
                    Colors.transparent,
                    Colors.transparent,
                    CustomColors.black,
                  ])),
          ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          ValueListenableBuilder(valueListenable: _movieCardController.animate,
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: showTitle,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: value? 1 : 0,
                    child: Text(
                        movie.releaseDate.isNotEmpty?movie.releaseDate.substring(0, 4):'',
                      style:
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                          shadows: [
                            const Shadow(
                              // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: CustomColors.lightNavy),
                            const Shadow(
                              // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: CustomColors.lightNavy),
                            const Shadow(
                              // topRight
                                offset: Offset(1.5, 1.5),
                                color: CustomColors.lightNavy),
                            const Shadow(
                              // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: CustomColors.lightNavy),
                          ]
                      )
                    ),
                  ),
                ),
                Visibility(
                  visible: showTitle,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: value? 1 : 0,
                    child: Text(
                      movie.title,
                      style:
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: movie.title.length > 7 ? 22 : 32,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.light,
                          shadows: const [
                            Shadow(
                              // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: CustomColors.lightNavy),
                            Shadow(
                              // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: CustomColors.lightNavy),
                            Shadow(
                              // topRight
                                offset: Offset(1.5, 1.5),
                                color: CustomColors.lightNavy),
                            Shadow(
                              // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: CustomColors.lightNavy),
                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Visibility(
                  visible: showBottonRatting,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: value? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: CustomColors.light,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))),
                                child: const Icon(Icons.play_arrow,
                                    color: CustomColors.darkNavy),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Assistir",
                                style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.light,
                                    shadows: [
                                      Shadow(
                                        // bottomLeft
                                          offset: Offset(-1.5, -1.5),
                                          color: CustomColors.lightNavy),
                                      Shadow(
                                        // bottomRight
                                          offset: Offset(1.5, -1.5),
                                          color: CustomColors.lightNavy),
                                      Shadow(
                                        // topRight
                                          offset: Offset(1.5, 1.5),
                                          color: CustomColors.lightNavy),
                                      Shadow(
                                        // topLeft
                                          offset: Offset(-1.5, 1.5),
                                          color: CustomColors.lightNavy),
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            RatingBar(
                              itemCount: 5,
                              itemSize: 18,
                              initialRating: movie.voteAverage / 2,
                              allowHalfRating: true,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star),
                                  half: const Icon(Icons.star_half),
                                  empty: const Icon(Icons.star_border)),
                              onRatingUpdate: (value) {},
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Container(
                            //   height: 30,
                            //   width: 30,
                            //   decoration: const BoxDecoration(
                            //       color: CustomColors.light,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(20))),
                            //   child: const Center(
                            //       child: Text(
                            //     '+18',
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         color: CustomColors.darkNavy,
                            //         fontWeight: FontWeight.bold),
                            //   )),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),)
           ,
      ),
      ],
    ),),
        )
    ,
    )
    ,
    );
  }
}
