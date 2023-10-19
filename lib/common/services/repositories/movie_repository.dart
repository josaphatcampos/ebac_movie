import 'dart:convert';

import 'package:http/http.dart';
import 'package:pre_projeto/common/model/catalog_model.dart';

import '../../model/movie_model.dart';
import '../../sistem/utils.dart';
class MovieRepository{
  static Client client = Client();

  MovieRepository();

  Future<Catalog> getPopularMovies()async{
    Map<String, String> param = {};
    param.addAll(Utils.apikey);
    var url = Uri.https('${Utils.movieApiBaseUrl}', Utils.movieApiPopularUrl, param);
print(url.toString());
    var response = await client.get(url);
print(response.body);
    final map = jsonDecode(response.body);
    print(map);
    return Catalog.fromMap(map);
  }
}