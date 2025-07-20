import 'package:get_it/get_it.dart';
import 'package:movie_app/data/services/movie_service.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';

final GetIt s1 = GetIt.instance;

void setupLocator() {
  s1.registerLazySingleton<MovieService>(() => MovieService());
  s1.registerLazySingleton<MovieRepository>(() => MovieRepository(s1()));
  s1.registerFactory(() => MovieCubit(s1()));
}