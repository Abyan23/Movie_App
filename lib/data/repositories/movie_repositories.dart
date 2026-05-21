import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/movie.dart';

class MovieRepositories {
  Future<List<Movie>> getMovies() async {
    final raw = await rootBundle.loadString('assets/data/movies.json');
    final List<dynamic> data = jsonDecode(raw);
    return data.map((json) => Movie.fromJson(json)).toList();
  }

Future<List<Movie>> searchMovies(String query) async {
  final movies = await getMovies();
  return movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
}

}