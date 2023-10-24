import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pre_projeto/common/component/app_bars/custom_inner_app_bar.dart';
import 'package:pre_projeto/common/component/buttons/custom_button.dart';
import 'package:pre_projeto/common/component/buttons/custom_icon_outline_button.dart';
import 'package:pre_projeto/movie/controller/movie_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/component/loading_component.dart';
import '../../common/sistem/colors.dart';
import '../../common/sistem/images.dart';
import '../../common/sistem/utils.dart';
import '../../common/sistem/values.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailController _movieDetailController = MovieDetailController();
  int movieId = 0;
  String tag = "";

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _movieDetailController.getMovie(movieId);
    });
  }

  @override
  void dispose() {
    _movieDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    movieId = arguments[CustomValues.movieIdParam] as int;
    tag = arguments[CustomValues.tagParam] as String;

    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _movieDetailController.isLoading,
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              color: CustomColors.darkNavy,
              image: DecorationImage(
                  image: NetworkImage(
                      '${Utils.movieApiOriginalUrl}${_movieDetailController.movie.backdropPath}',
                  ),
                  opacity: 0.6,

                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
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
            appBar: const CustomInnerAppBar(),
            body: Padding(
              padding: EdgeInsets.only(
                  right: CustomValues.paddingInnerBorder,
                  left: CustomValues.paddingInnerBorder),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: ValueListenableBuilder(
                        valueListenable: _movieDetailController.isLoading,
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: CustomValues.marginComponent,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RepaintBoundary(
                                        key: _globalKey,
                                        child: Hero(
                                          tag: tag,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CustomColors.lightNavy,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${Utils.movieApiImageUrl}${_movieDetailController.movie.posterPath}'),
                                                    fit: BoxFit.cover)),
                                            height: 300,
                                            width: 200,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                90,
                                        child: Text(
                                          _movieDetailController.movie.title,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CustomIconOutlineButton(
                                          iconData: Icons.favorite,
                                          iconPadding: 10,
                                          iconSIze: 22,
                                          iconRound: 12,
                                          function: () {}),
                                      Text(Utils.getFormatNumber(
                                          _movieDetailController
                                              .movie.voteCount)),

                                      SizedBox(height: CustomValues.marginComponent,),
                                      CustomIconOutlineButton(
                                          iconData: Icons.ios_share,
                                          iconPadding: 10,
                                          iconSIze: 22,
                                          iconRound: 12,
                                          function: () async {
                                            await _movieDetailController.capturePng(_globalKey);
                                          }),
                                      const Text("Enviar",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              RatingBar(
                                itemCount: 5,
                                itemSize: 18,
                                initialRating:
                                    _movieDetailController.movie.voteAverage! /
                                        2,
                                allowHalfRating: true,
                                ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      color: CustomColors.yellow,
                                    ),
                                    half: const Icon(Icons.star_half,
                                        color: CustomColors.yellow),
                                    empty: const Icon(Icons.star_border)),
                                onRatingUpdate: (value) {},
                              ),
                              Visibility(
                                visible: _movieDetailController
                                    .movie.homepage.isNotEmpty,
                                child: TextButton(
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.only(left: 0))),
                                  onPressed: () async {
                                    var url = Uri.parse(
                                        _movieDetailController.movie.homepage);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  child: Text(
                                    _movieDetailController.movie.homepage,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.gray),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: CustomValues.marginComponent,
                              ),
                              const Text(
                                "Sinopse",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _movieDetailController.movie.overview.isNotEmpty
                                    ? _movieDetailController.movie.overview
                                    : "Ainda não possui sinopse",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.gray),
                              ),
                              SizedBox(
                                height: CustomValues.marginComponent,
                              ),
                              CustomButton(
                                  title: "Abrir no IMDB",
                                  onPressed: () async {
                                    var url = Uri.parse(
                                        "https://www.imdb.com/title/${_movieDetailController.movie.imdbId}");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  }),
                              SizedBox(
                                height: CustomValues.paddingBorder,
                              )
                            ],
                          );
                        }),
                  ),
                  LoadingComponent(isLoading: _movieDetailController.isLoading)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
