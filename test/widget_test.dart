import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_discovery/data/models/movie.dart';
import 'package:movie_discovery/data/repositories/movie_repositories.dart';

class MockMovieRepositories extends Mock implements MovieRepositories {}

void main() {
  late MockMovieRepositories mockRepo;

  setUp(() {
    mockRepo = MockMovieRepositories();
  });

  group('MovieRepositories', () {
    // Test 1 — sukses ambil data
    test('getMovies returns list movies dalam keadaan berhasil', () async {
      final fakeMovies = [
        Movie(
          id: 1,
          title: 'Inception',
          overview: 'A thief who steals corporate secrets.',
          releaseDate: '2010-07-16',
          voteAverage: 8.8,
          runtime: 148,
          genres: ['Action', 'Sci-Fi'],
          posterUrl: 'https://picsum.photos/seed/movie1/500/750',
          backdropUrl: 'https://picsum.photos/seed/movie1back/1280/720',
        ),
      ];

      when(() => mockRepo.getMovies()).thenAnswer((_) async => fakeMovies);

      final result = await mockRepo.getMovies();

      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
      expect(result.first.title, 'Inception');
    });

    // Test 2 — gagal / error
    test('getMovies throws exception jika gagal', () async {
      when(() => mockRepo.getMovies()).thenThrow(Exception('Gagal di load'));

      expect(() => mockRepo.getMovies(), throwsException);
    });

    // Test 3 — search movies
    test('searchMovies returns hasil yang dicari', () async {
      final fakeMovies = [
        Movie(
          id: 1,
          title: 'Inception',
          overview: 'A thief.',
          releaseDate: '2010-07-16',
          voteAverage: 8.8,
          runtime: 148,
          genres: ['Action'],
          posterUrl: 'https://picsum.photos/seed/movie1/500/750',
          backdropUrl: 'https://picsum.photos/seed/movie1back/1280/720',
        ),
      ];

      when(() => mockRepo.searchMovies('Inception'))
          .thenAnswer((_) async => fakeMovies);

      final result = await mockRepo.searchMovies('Inception');

      expect(result.first.title, 'Inception');
      expect(result.length, 1);
    });
  });
}