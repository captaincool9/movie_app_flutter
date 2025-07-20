import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/service_locator.dart';
import 'package:movie_app/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/presentation/cubit/movie_state.dart';
import 'package:movie_app/presentation/screens/movie_detail_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => s1<MovieCubit>()..fetchMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular Movies'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              final movies = state.movies;
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: movies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: movie.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                                width: 60,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.movie, size: 32),
                              ),
                      ),
                      title: Text(
                        movie.title ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        movie.releaseDate ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailScreen(movie: movie),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is MovieError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: \n ${state.message}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MovieCubit>().fetchMovies();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
