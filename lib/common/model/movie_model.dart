import 'dart:ffi';

/// adult : false
/// backdrop_path : "/mRGmNnh6pBAGGp6fMBMwI8iTBUO.jpg"
/// genre_ids : [27,9648,53]
/// id : 968051
/// original_language : "en"
/// original_title : "The Nun II"
/// overview : "Quatro anos após os acontecimentos na abadia de St. Carta, a Irmã Irene (Taissa Farmiga) regressa mais uma vez e depara-se com a força demoníaca de Valak, a Freira (Bonnie Aarons)."
/// popularity : 1706.801
/// poster_path : "/omV2IW2OlFTSw6Hih13hz6lFdvP.jpg"
/// release_date : "2023-09-06"
/// title : "A Freira 2"
/// video : false
/// vote_average : 7
/// vote_count : 1011

class Movie {
  bool adult;
  String backdropPath;
  List<dynamic> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount});


  factory Movie.fromMovie(){
    return Movie(adult: false,
        backdropPath: "",
        genreIds:  <dynamic>[],
        id: 0,
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 0.0,
        posterPath: "",
        releaseDate: "",
        title: "",
        video: false,
        voteAverage:0,
        voteCount: 0);
  }



  Map<String, dynamic> toMap() {
    return {
      'adult': this.adult,
      'backdropPath': this.backdropPath,
      'genreIds': this.genreIds,
      'id': this.id,
      'originalLanguage': this.originalLanguage,
      'originalTitle': this.originalTitle,
      'overview': this.overview,
      'popularity': this.popularity,
      'posterPath': this.posterPath,
      'releaseDate': this.releaseDate,
      'title': this.title,
      'video': this.video,
      'voteAverage': this.voteAverage,
      'voteCount': this.voteCount,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: map['genre_ids'] ?? <dynamic>[],
      id: map['id'] ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: double.parse("${map['popularity']}") ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: double.parse("${map['vote_average']}") ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
    );
  }
}
