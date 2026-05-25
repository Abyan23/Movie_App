import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Cari film',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if(_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(const Duration(milliseconds: 300),(){
            context.read<MovieProvider>().searchMovies(value);
            });
          },
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchResult.isEmpty) {
            return const Center(
              child: Text('Film tidak tersedia'), 
              );
          }
        return ListView.builder(
          itemCount: provider.searchResult.length,
          itemBuilder: (context, index){
            final movie = provider.searchResult[index];
            return ListTile(
              leading: Image.network(
                movie.posterUrl,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(movie.title),
              subtitle: Text('${movie.releaseDate.substring(0,4)} ${movie.voteAverage}'),
            );
          },
        );

        } 
        ,
        child: Text('Hasil pencarian muncul di sini'),
      ),
    );
  }
}