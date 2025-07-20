import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/services/movie_service.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/presentation/screens/movie_list_screen.dart';

import 'core/service_locator.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(create: (context) =>
          MovieCubit(MovieRepository(MovieService()))..fetchMovies(),
        child: MovieListScreen(),
      ),
    );
  }
}

