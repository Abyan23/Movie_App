import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fav_provider.dart';
import 'details_screen.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
      ),
        body: Consumer<FavProvider>(
          builder: (context, fav, _){
            if(fav.favorite.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 64),
                    Text('Belum ada Film Favorit'),
                  ],
                ) ,
                );
            }

            return ListView.builder(
              itemCount: fav.favorite.length,
              itemBuilder: (context, index) {
                final movie = fav.favorite[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(movie: movie,)  
                    ),
                  ),
                  leading: Image.network(
                    movie.posterUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text('${movie.releaseDate.substring(0,4)} ${movie.voteAverage}'),
                  trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => fav.toggleFavorite(movie)
                  ),
                );
              },


            );

          }),
    );
  }
}