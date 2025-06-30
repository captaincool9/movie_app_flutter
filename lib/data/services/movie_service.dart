import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MovieService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '9dc1885929623ca4136080285e58e5a9'; // Replace with your actual API key

  Future<MovieModel>
  fetchPopularMovies() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
        },
      );

      return
        MovieModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Error fetching popular movies: $e");
      rethrow;
    }
  }
}