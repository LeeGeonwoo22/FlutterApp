class MoviesModel {
  final bool adult, video;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final int id, popularity, voteAverage, voteCount;
  final List<int> genreIds;

  MoviesModel({
    required this.adult,
    required this.video,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.id,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
  });
}
