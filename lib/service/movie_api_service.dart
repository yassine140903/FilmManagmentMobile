import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieApiService {
  // Replace with your RapidAPI key
  static const String _rapidApiKey = 'YOUR_RAPIDAPI_KEY_HERE';
  static const String _rapidApiHost = 'moviesdatabase.p.rapidapi.com';
  static const String _baseUrl = 'https://moviesdatabase.p.rapidapi.com';

  // Fetch popular movies
  static Future<List<Map<String, dynamic>>> getPopularMovies({
    int page = 1,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/titles?page=$page&limit=20'),
        headers: {
          'X-RapidAPI-Key': _rapidApiKey,
          'X-RapidAPI-Host': _rapidApiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((movie) => _parseMovie(movie)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
      return [];
    }
  }

  // Search movies
  static Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/titles/search/title/$query?limit=20'),
        headers: {
          'X-RapidAPI-Key': _rapidApiKey,
          'X-RapidAPI-Host': _rapidApiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((movie) => _parseMovie(movie)).toList();
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching movies: $e');
      return [];
    }
  }

  // Get movies by genre
  static Future<List<Map<String, dynamic>>> getMoviesByGenre(
      String genre, {
        int page = 1,
      }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/titles?genre=$genre&page=$page&limit=20'),
        headers: {
          'X-RapidAPI-Key': _rapidApiKey,
          'X-RapidAPI-Host': _rapidApiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((movie) => _parseMovie(movie)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies by genre: $e');
      return [];
    }
  }

  // Parse movie data
  static Map<String, dynamic> _parseMovie(Map<String, dynamic> movie) {
    return {
      'id': movie['id'] ?? '',
      'title': movie['titleText']?['text'] ?? 'Unknown Title',
      'year': movie['releaseYear']?['year']?.toString() ?? 'N/A',
      'genre': _parseGenres(movie['genres']),
      'rating': movie['ratingsSummary']?['aggregateRating']?.toString() ?? 'N/A',
      'poster': movie['primaryImage']?['url'] ??
          'https://via.placeholder.com/300x450?text=No+Image',
      'type': movie['titleType']?['text'] ?? 'Movie',
    };
  }

  // Parse genres
  static String _parseGenres(dynamic genres) {
    if (genres == null) return 'Unknown';
    if (genres is List && genres.isNotEmpty) {
      return genres
          .map((g) => g['text'] ?? '')
          .where((text) => text.isNotEmpty)
          .take(2)
          .join(', ');
    }
    return 'Unknown';
  }
}