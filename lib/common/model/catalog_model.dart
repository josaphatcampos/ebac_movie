import 'movie_model.dart';

class Catalog {
  int? page;
  int? totalPages;
  int? totalResults;
  List<Movie> movies;

  Catalog({required this.movies, this.page, this.totalPages, this.totalResults});

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'totalPages': totalPages,
      'totalResults': totalResults,
      'movies': movies,
    };
  }

  factory Catalog.fromMap(Map<String, dynamic> json) {
    int page = json['page'];
    List<Movie> movies = <Movie>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        movies!.add(Movie.fromMap(v));
      });
    }
    int totalPages = json['total_pages'];
    int totalResults = json['total_results'];

    return Catalog(
        movies: movies,
        page: page,
        totalPages: totalPages,
        totalResults: totalResults);
  }
}
