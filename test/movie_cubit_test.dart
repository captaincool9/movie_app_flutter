/*
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/presentation/cubit/movie_state.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';


void main() {
  late MockMovieRepository mockRepository;
  late MovieCubit movieCubit;

  setUp(() {
    mockRepository = MockMovieRepository();
    movieCubit = MovieCubit(mockRepository);
  });

  tearDown(() {
    movieCubit.close();
  });

  test('initial state is MovieInitial',() {
    expect(movieCubit.state, MovieInitial());
  });

  blocTest<MovieCubit, MovieState>(
    'emits [MovieLoading, MovieLoaded] when fetchMovies succeeds',
    build: () {
      when(mockRepository.getPopularMovies()).thenAnswer((_) async => [
        Results(title: "Interstellar", id: 1, overview: "A space exploration movie", posterPath: "", releaseDate: "2024"),
      ]);
      return movieCubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      isA<MovieLoaded>(),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'emits [MovieLoading, MovieError] when fetchMovies fails',
    build: () {
      when(mockRepository.getPopularMovies()).thenThrow(Exception('Failed'));
      return movieCubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );
}*/


import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/presentation/cubit/movie_state.dart';
import 'package:movie_app/data/models/movie_model.dart';

import 'mocks.mocks.dart';

// Mock repository

void main() {
  late MockMovieRepository mockRepository;
  late MovieCubit movieCubit;

  setUp(() {
    mockRepository = MockMovieRepository();
    movieCubit = MovieCubit(mockRepository);
  });

  tearDown(() {
    movieCubit.close();
  });

  final mockMovies = [
    Results(id: 1, title: 'Movie 1'),
    Results(id: 2, title: 'Movie 2'),
  ];

  blocTest<MovieCubit, MovieState>(
    'emits [MovieLoading, MovieLoaded] when fetchMovies succeeds',
    build: () {
      when(mockRepository.getPopularMovies()).thenAnswer((_) async => mockMovies);
      return movieCubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      MovieLoaded(mockMovies),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'emits [MovieLoading, MovieError] when fetchMovies fails',
    build: () {
      when(mockRepository.getPopularMovies()).thenThrow(Exception('Failed'));
      return movieCubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );
}
