import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/services/movie_service.dart';

class MovieRepository{
  final MovieService _movieService;

  MovieRepository(this._movieService);
  Future<List<Results>>
  getPopularMovies() async {
    final response = await _movieService.fetchPopularMovies();
    return response.results ?? [];
  }
}