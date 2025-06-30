import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/presentation/cubit/movie_state.dart';

class MovieCubit extends
    Cubit<MovieState> {
  final MovieRepository repository;

  MovieCubit(this.repository) : super(MovieInitial());
  void fetchMovies() async {
    emit(MovieLoading());
    try {
      final movies = await repository.getPopularMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError("Something went wrong.\n${e.toString()}"));
    }
  }
}