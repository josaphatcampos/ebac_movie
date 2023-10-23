import 'package:flutter/cupertino.dart';
import 'package:pre_projeto/common/services/repositories/movie_repository.dart';

import '../../common/model/movie_detail_model.dart';

class MovieDetailController {
  MovieRepository repository = MovieRepository();

  MovieDetail movie = MovieDetail.fromDetail();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void dispose(){
    isLoading.dispose();
  }

  void getMovie(int id) async {
    isLoading.value = true;
    movie = await repository.getMovieDetail(id);
    isLoading.value = false;
  }

}