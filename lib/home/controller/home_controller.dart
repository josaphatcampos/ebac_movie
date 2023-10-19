
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:pre_projeto/common/model/catalog_model.dart';
import 'package:pre_projeto/common/services/repositories/movie_repository.dart';

import '../../common/model/movie_model.dart';

class HomeController{
  final CarouselController carouselController = CarouselController();
  List<Movie> banner = [];
  Catalog popular = Catalog(movies: []);
  MovieRepository movieRepository = MovieRepository();

  ValueNotifier<int> carouselPage = ValueNotifier<int>(0);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  HomeController(){
    getMovies();
  }

  void getMovies() async {
    isLoading.value = true;
    popular = await movieRepository.getPopularMovies();
    banner = popular.movies.sublist(0, 5);
    isLoading.value = false;
  }

}