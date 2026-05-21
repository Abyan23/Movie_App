import 'package:flutter/material.dart';
import '../data/models/movie.dart';
import '../data/repositories/movie_repositories.dart';

class MovieProvider extends ChangeNotifier{
  final _repositories = MovieRepositories();

  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  List<Movie> get searchResult => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void>loadMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _repositories.getMovies();
      _error = '';
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
}
 
  Future<void>searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _repositories.searchMovies(query);
      _error = '';
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
}
}

