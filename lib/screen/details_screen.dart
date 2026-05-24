import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/movie.dart';
import '../providers/fav_provider.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
              background: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              Consumer<FavProvider>(
                builder: (context, fav, _) {
                  final isFav = fav.favorite.any((m) => m.id == movie.id);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                    ),
                    onPressed: () => fav.toggleFavorite(movie),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: movie.genres.map((g) => Chip(
                      label: Text(g),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${movie.voteAverage}',
                        style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 20),
                      const SizedBox(width: 4),
                      Text('${movie.runtime} menit',
                        style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 4),
                      Text(movie.releaseDate,
                        style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Sinopsis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(movie.overview,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}