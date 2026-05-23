class Movie {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final List<String> genres;
  final String posterUrl;
  final String backdropUrl;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
    required this.posterUrl,
    required this.backdropUrl,
  });

  // Konversi JSON → object Movie
factory Movie.fromJson(Map<String, dynamic> json) {
  return Movie(
    id: (json['id'] as num).toInt(),
    title: json['title'],
    overview: json['overview'],
    releaseDate: json['release_date'],
    voteAverage: (json['vote_average'] as num).toDouble(),
    runtime: (json['runtime'] as num).toInt(),
    genres: List<String>.from(json['genres']),
    posterUrl: json['poster_url'],
    backdropUrl: json['backdrop_url'],
  );
}

  // Konversi object Movie → JSON (untuk simpan favorit)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'overview': overview,
    'release_date': releaseDate,
    'vote_average': voteAverage,
    'runtime': runtime,
    'genres': genres,
    'poster_url': posterUrl,
    'backdrop_url': backdropUrl,
  };
}