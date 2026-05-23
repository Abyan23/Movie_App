import 'package:flutter/material.dart';
import 'package:movie_discovery/data/models/movie.dart';
import 'package:movie_discovery/screen/search_screen.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../providers/fav_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<MovieProvider>().loadMovies()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Discovery'),
        actions: [
          IconButton(
            icon : const Icon(Icons.search),  
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),  
                )
              );
            },
      )],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child){
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if(provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error : ${provider.error}'),
                  ElevatedButton(onPressed: () => context.read<MovieProvider>().loadMovies(),
                  child : const Text ('Retry'),
                  )
                ],
              ),
            );
          }

if (provider.movies.isEmpty) {
  return const Center(
    child: Text('Tidak ada film tersedia'),
  );
}

return RefreshIndicator(
  onRefresh: () => context.read<MovieProvider>().loadMovies(),
  child: GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.6,
    ),
    itemCount: provider.movies.length,
itemBuilder: (context, index) {
  final movie = provider.movies[index];
  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Placeholder(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Consumer<FavProvider>(
                    builder: (context, fav, _) {
                      final isFav = fav.favorite.any((m) => m.id == movie.id);
                      return GestureDetector(
                        onTap: () => fav.toggleFavorite(movie),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.white,
                            size: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.genres.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${movie.voteAverage}',
                      style: const TextStyle(fontSize: 11)),
                    const Spacer(),
                    const Icon(Icons.access_time, size: 12),
                    const SizedBox(width: 2),
                    Text('${movie.runtime}m',
                      style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
},
  ),
);

        },)
    );
  }
}