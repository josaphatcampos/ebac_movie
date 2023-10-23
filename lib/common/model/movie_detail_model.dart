import 'genre_model.dart';

class MovieDetail {
  bool adult;
  String backdropPath;
  int budget;
  List<Genre>? genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetail({ required this.adult,
    required this.backdropPath,
    required this.budget,
    this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount});


  factory MovieDetail.fromDetail(){
    return MovieDetail(adult: false,
        backdropPath: "",
        budget: 0,
        homepage: "",
        id: 0,
        imdbId: "",
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 0,
        posterPath: "",
        releaseDate: "",
        revenue: 0,
        runtime: 0,
        status: "",
        tagline: "",
        title: "",
        video: false,
        voteAverage: 0,
        voteCount: 0);
  }


  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> genrelist = [];
    if (genres != null) {
      genrelist = genres!.map((v) => v.toJson()).toList();
    }
    return {
      'adult': adult,
      'backdropPath': backdropPath,
      'budget': budget,
      'genres': genrelist,
      'homepage': homepage,
      'id': id,
      'imdbId': imdbId,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory MovieDetail.fromMap(Map<String, dynamic> json) {
    List<Genre> genres = [];
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres!.add(Genre.fromJson(v));
      });
    }
    return MovieDetail(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] ?? "",
      budget: json['budget'] ?? 0,
      genres: genres,
      homepage: json['homepage'] ?? "",
      id: json['id'] ?? "",
      imdbId: json['imdb_id'] ?? "",
      originalLanguage: json['original_language'] ?? "",
      originalTitle: json['original_title'] ?? "",
      overview: json['overview'] ?? "",
      popularity: json['popularity'] ?? 0.0,
      posterPath: json['poster_path'] ?? "",
      releaseDate: json['release_date'] ?? "",
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? "",
      tagline: json['tagline'] ?? "",
      title: json['title'] ?? "",
      video: json['video'] ?? false,
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'MovieDetail{adult: $adult, backdropPath: $backdropPath, budget: $budget, genres: $genres, homepage: $homepage, id: $id, imdbId: $imdbId, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, revenue: $revenue, runtime: $runtime, status: $status, tagline: $tagline, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}