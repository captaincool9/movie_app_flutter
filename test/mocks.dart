import 'package:mockito/annotations.dart';
import 'package:movie_app/data/services/movie_service.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';

@GenerateMocks([MovieRepository, MovieService, MovieCubit])
void main() {}

