/*
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'mocks.mocks.dart';

void main() {
  late MockMovieService mockMovieService;
  late MovieRepository movieRepository;

  setUp(() {
    mockMovieService = MockMovieService();
    movieRepository = MovieRepository(mockMovieService);
  });

  test('should return a list of popular movies', () async {
    // Arrange
    final mockResponse = MovieModel(
      page: 1,
      results: [
        Results(
          id: 1,
          title: 'Mock Movie',
          releaseDate: '2023-01-01',
          voteAverage: 8.5,
        ),
      ],
      totalPages: 1,
      totalResults: 1,
    );

    when(mockMovieService.fetchPopularMovies())
        .thenAnswer((_) async => mockResponse);

    // Act
    final movies = await movieRepository.getPopularMovies();

    // Assert
    expect(movies.length, 1);
    expect(movies.first.title, 'Mock Movie');
  });
}*/


import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'mocks.mocks.dart';


void main() {
  late MockMovieService mockService;
  late MovieRepository repository;

  setUp(() {
    mockService = MockMovieService();
    repository = MovieRepository(mockService);
  });

  final mockMovieModel = MovieModel(
    page: 1,
    results: [
      Results(id: 1, title: 'Movie 1'),
      Results(id: 2, title: 'Movie 2'),
    ],
    totalPages: 1,
    totalResults: 2,
  );

  test('getPopularMovies returns movies from service', () async {
    when(mockService.fetchPopularMovies()).thenAnswer((_) async => mockMovieModel);

    final result = await repository.getPopularMovies();

    expect(result.length, 2);
    expect(result.first.title, 'Movie 1');
    verify(mockService.fetchPopularMovies()).called(1);
  });

  test('getPopularMovies throws when service throws', () async {
    when(mockService.fetchPopularMovies()).thenThrow(Exception('error'));

    expect(() => repository.getPopularMovies(), throwsException);
  });
}
