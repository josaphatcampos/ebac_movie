import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:pre_projeto/common/interface/custom_controller_contract.dart';
import 'package:pre_projeto/common/model/catalog_model.dart';
import 'package:pre_projeto/common/services/repositories/movie_repository.dart';
import 'package:uuid/uuid.dart';
import '../../common/model/movie_model.dart';

class HomeController extends CustomControllerContract {
  MovieRepository movieRepository = MovieRepository();
  Catalog popular = Catalog(movies: []);
  Catalog topMovies = Catalog(movies: []);
  Catalog moviesInTheatre = Catalog(movies: []);
  Catalog upcommingMovies = Catalog(movies: []);

  Catalog searchMovies = Catalog(movies: []);

  var uuid = const Uuid();

  List<Movie> banner = [];

  final CarouselController carouselController = CarouselController();

  ValueNotifier<int> carouselPage = ValueNotifier<int>(0);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<bool> isSearch = ValueNotifier<bool>(false);
  ValueNotifier<int> change = ValueNotifier<int>(0);
  ValueNotifier<String> searchterm = ValueNotifier<String>("");

  HomeController() {
    getBannerMovies();
    getTopMovies();
    getUpcomming();
    getInTheatre();

    isSearch.addListener(() {
      if(!isSearch.value){
        searchterm.value = "";
      }
    });


  }

  void dispose() {
    change.dispose();
    carouselPage.dispose();
    isLoading.dispose();
    isSearch.dispose();
    searchterm.dispose();
  }

  void getBannerMovies() async {
    isLoading.value = true;
    popular = await movieRepository.getPopularMovies();
    int max = 5 + Random().nextInt(popular.movies.length - 5);
    int min = max - 5;
    banner = popular.movies.sublist(min, max);
    carouselPage.value = banner.length;
    isLoading.value = false;
  }

  void getTopMovies() async {
    topMovies = await movieRepository.getTopMovies();
    change.value = change.value + topMovies.movies.length;
  }

  void getUpcomming() async {
    upcommingMovies = await movieRepository.getUpcommingMovies();
    change.value = change.value + upcommingMovies.movies.length;
  }

  void getInTheatre() async {
    moviesInTheatre = await movieRepository.getNowInTheatMovies();
    change.value = change.value + moviesInTheatre.movies.length;
  }

  Future<Catalog> _getSearch(String term) async {
    return await movieRepository.getSearchMovies(term);
  }

  @override
  Future<void> search({required String searchTerm}) async {
    searchMovies.movies.clear();

    if(searchTerm.isNotEmpty && searchterm.value != searchTerm){
      isSearch.value = true;
      isLoading.value = true;

      // isFindSearch.value = true;

      searchMovies = await _getSearch(searchTerm);
      // isFindSearch.value = searchMovies.movies.isNotEmpty;

      searchterm.value = searchTerm;
      isSearch.value = true;
      isLoading.value = false;
    }else {
      // isFindSearch.value = false;
      isSearch.value = false;
    }
  }
}
