import 'dart:convert';

import 'package:http/http.dart';
import 'package:pre_projeto/common/model/catalog_model.dart';
import 'package:pre_projeto/common/model/movie_detail_model.dart';

import '../../sistem/utils.dart';
class MovieRepository{
  static Client client = Client();

  MovieRepository();

  Future<Catalog> getPopularMovies()async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, Utils.movieApiPopularUrl, param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);

    return Catalog.fromMap(map);
  }

  Future<Catalog> getUpcommingMovies()async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, Utils.movieApiUpcomingUrl, param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);

    return Catalog.fromMap(map);
  }

  Future<Catalog> getTopMovies()async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, Utils.movieApiTopUrl, param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);

    return Catalog.fromMap(map);
  }

  Future<Catalog> getNowInTheatMovies()async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, Utils.movieApiNowInTheatUrl, param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);

    return Catalog.fromMap(map);
  }

  Future<Catalog> getSearchMovies(String term)async{
    Map<String, String> param = {"query":term};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, Utils.movieApiSearchUrl, param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);
    return Catalog.fromMap(map);
  }

  Future<MovieDetail> getMovieDetail(int id)async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);

    var url = Uri.https(Utils.movieApiBaseUrl, '${Utils.movieApiMovieUrl}/$id', param);

    var response = await client.get(url);
    final map = jsonDecode(response.body);
    return MovieDetail.fromMap(map);
  }
}