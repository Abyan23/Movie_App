import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/movie.dart';

class FavProvider extends ChangeNotifier{
  List<Movie> _favorite = [];

  List<Movie> get favorite => _favorite;

Future<void> loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('Favorit') ?? [];
  _favorite = jsonList
  .map((s) => Movie.fromJson(jsonDecode(s)))
  .toList();
  notifyListeners();
}

  Future<void> toggleFavorite(Movie movie) async {
    if (_favorite.any((m) => m.id == movie.id)) {
      _favorite.removeWhere((m) => m.id == movie.id);
    } else {
      _favorite.add(movie);
    } 
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _favorite.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList('Favorit', jsonList);
  }

}