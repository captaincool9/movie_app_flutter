import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final Results movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: 'movie_${movie.id}',
            child: movie.backdropPath != null
                ? Image.network(
              'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
              width: double.infinity,
              height: 340,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: 340,
              color: Colors.grey[800],
            ),
          ),
          Container(
            height: 340,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.95)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 280, left: 0, right: 0, bottom: 24),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: movie.posterPath != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w300${movie.posterPath}',
                        height: 300,
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    movie.title ?? '',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.originalTitle ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _InfoChip(icon: Icons.star, label: '${movie.voteAverage ?? ''}'),
                      _InfoChip(icon: Icons.calendar_today, label: movie.releaseDate ?? ''),
                      _InfoChip(icon: Icons.language, label: movie.originalLanguage ?? ''),
                      _InfoChip(icon: Icons.people, label: '${movie.voteCount ?? ''} votes'),
                      _InfoChip(icon: Icons.trending_up, label: '${movie.popularity ?? ''}'),
                      if (movie.adult == true) _InfoChip(icon: Icons.warning, label: '18+'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Overview',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  if (movie.genreIds != null && movie.genreIds!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: movie.genreIds!
                          .map((id) => Chip(
                        label: Text('Genre $id'),
                        backgroundColor: Colors.deepPurple[400],
                        labelStyle: const TextStyle(color: Colors.white),
                      ))
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 18),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.deepPurple[700],
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}