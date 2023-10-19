import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pre_projeto/common/model/catalog_model.dart';
import 'package:pre_projeto/common/sistem/routes.dart';
import 'package:pre_projeto/common/sistem/utils.dart';

import '../../model/movie_model.dart';
import '../../sistem/colors.dart';
import '../../sistem/values.dart';
import '../cards/movie_card.dart';
class MovieList extends StatelessWidget {

  final String title;
  final Catalog catalog;
  final bool showDuration;

  const MovieList({
    super.key, required this.title, required this.catalog,  this.showDuration = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: CustomValues.paddingInnerBorder,),
        SizedBox(
          height: 220,
          child: ListView.builder(
            itemCount: catalog.movies.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Movie movie = catalog.movies[index];
              print(movie.posterPath);
              print('${Utils.movieApiImageUrl}${movie.posterPath}');
              return  Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MovieCard(
                      movie: movie,
                      imageUrl: '${movie.posterPath}',
                      showBottonRatting: false,
                      showTitle: false,
                      width: 129,
                      height: 160,
                      rounded: 18,
                      function: (){
                        Navigator.of(context).pushNamed(Routes.movieDetail, arguments: 'The Batman');
                      },
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(width: 129, child: Text(movie.title, maxLines: 1, style: const TextStyle(fontSize: 12),)),
                    const SizedBox(height: 5,),
                    Visibility(
                      visible: showDuration,
                      child: Container(
                        height: 5,
                        width: 100,
                        padding: EdgeInsets.only(right: 60),
                        decoration: const BoxDecoration(
                            color: CustomColors.lightNavy,
                            borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                        child:
                        Container(
                          height: 5,
                          width: 2,
                          decoration: const BoxDecoration(
                              color: CustomColors.red,
                              borderRadius: BorderRadius.all(Radius.circular(2))
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !showDuration,
                        child: RatingBar(
                      itemCount: 5,
                      itemSize: 18,
                      initialRating: movie.voteAverage / 2,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(full: const Icon(Icons.star), half: const Icon(Icons.star_half), empty: const Icon(Icons.star_border)),
                      onRatingUpdate: (value){},))

                  ],
                ),
              );
            },),
        )
      ],
    );
  }
}