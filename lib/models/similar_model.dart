import 'dart:convert';

class SimilarMovie {
  SimilarMovie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String title;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  String? heroId;

  get posterImg {
    if (this.posterPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get headerBack {
    if (this.backdropPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory SimilarMovie.fromJson(String str) =>
      SimilarMovie.fromMap(json.decode(str));

  factory SimilarMovie.fromMap(Map<String, dynamic> json) => SimilarMovie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
