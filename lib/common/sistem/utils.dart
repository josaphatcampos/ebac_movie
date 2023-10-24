import 'dart:convert';

import 'package:pre_projeto/common/model/user_model.dart';
import 'package:pre_projeto/common/sistem/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Utils._();
  //https://www.themoviedb.org
  static const Map<String, String> apikey = {
    'api_key': '',
    'language': 'pt-BR',
    'region': 'BR'
  };

  static const String movieApiBaseUrl = 'api.themoviedb.org';
  static const String movieApiMovieUrl = '/3/movie';
  static const String movieApiSearchBaseUrl = '/3/search';
  static const String movieApiPopularUrl = '$movieApiMovieUrl/popular';
  static const String movieApiTopUrl = '$movieApiMovieUrl/top_rated';
  static const String movieApiUpcomingUrl = '$movieApiMovieUrl/upcoming';
  static const String movieApiNowInTheatUrl = '$movieApiMovieUrl/now_playing';
  static const String movieApiSearchUrl = '/3/search/movie';
  static const String movieApiImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String movieApiOriginalUrl ='https://image.tmdb.org/t/p/original';

  static const int movieGenreAction = 28;
  static const int movieGenreAdventure = 12;
  static const int movieGenreComedy = 35;

  static User? globalUser;

  static String getFormatNumber(int value) {
    int convert = value ?? 0;

    if (convert > 999999) {
      return "+${(convert / 1000000).toStringAsFixed(1)}M"
          .replaceAll(".0", "")
          .replaceAll(".", ",");
    } else if (convert > 9999) {
      return "+${(convert / 1000).toStringAsFixed(1)}K"
          .replaceAll(".0", "")
          .replaceAll(".", ",");
    }

    return "$convert";
  }

  static Future<bool> checkAlreadyLogged() async {
    final prefs = await SharedPreferences.getInstance();
    try{
      String? userString = await prefs.getString(CustomValues.userkey);
      globalUser = User.fromMap(jsonDecode(userString!));
      return globalUser!.nickName.isNotEmpty;
    }catch(e){
      return false;
    }
  }
}

// {
// "genres": [
// {
// "id": 28,
// "name": "Action"
// },
// {
// "id": 12,
// "name": "Adventure"
// },
// {
// "id": 16,
// "name": "Animation"
// },
// {
// "id": 35,
// "name": "Comedy"
// },
// {
// "id": 80,
// "name": "Crime"
// },
// {
// "id": 99,
// "name": "Documentary"
// },
// {
// "id": 18,
// "name": "Drama"
// },
// {
// "id": 10751,
// "name": "Family"
// },
// {
// "id": 14,
// "name": "Fantasy"
// },
// {
// "id": 36,
// "name": "History"
// },
// {
// "id": 27,
// "name": "Horror"
// },
// {
// "id": 10402,
// "name": "Music"
// },
// {
// "id": 9648,
// "name": "Mystery"
// },
// {
// "id": 10749,
// "name": "Romance"
// },
// {
// "id": 878,
// "name": "Science Fiction"
// },
// {
// "id": 10770,
// "name": "TV Movie"
// },
// {
// "id": 53,
// "name": "Thriller"
// },
// {
// "id": 10752,
// "name": "War"
// },
// {
// "id": 37,
// "name": "Western"
// }
// ]
// }
