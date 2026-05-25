import 'package:flutter/material.dart';
import '../data/models/movie.dart';
import '../data/repositories/movie_repositories.dart';

class MovieProvider extends ChangeNotifier{
  final _repositories = MovieRepositories();

  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  List<Movie> _allMovies = [];
  int _currentPage = 0;
  final int _perPage = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  List<Movie> get searchResult => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void>loadMovies() async {
    _isLoading = true;
    _currentPage = 0;
    _movies = [];
    _hasMore = true;
    notifyListeners();

    try {
      _allMovies = await _repositories.getMovies();
      _loadNextPage();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
}

void _loadNextPage() {

  final start = _currentPage * _perPage;
  final end = start + _perPage;

  if (start >= _allMovies.length) {
    _hasMore = false;
    notifyListeners();
    return;
  }

  final nextItems = _allMovies.sublist(
    start,
    end > _allMovies.length ? _allMovies.length : end,
  );

  _movies.addAll(nextItems);
  _currentPage++;
  _hasMore = end < _allMovies.length;
  notifyListeners();
}

  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) 
    return;
    _loadNextPage();
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

