import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/movieDetails/model/movie_details_model.dart';
import 'package:movies_app/core/utils/app_constants.dart';
import 'package:movies_app/core/utils/app_endpoints.dart';

class MovieDetailsApi {
  static Future<MovieDetails?> getMovieDetails(String movieId) async {
    Uri uri = Uri.https(
        AppConstants.moviesBaseUrl,
        AppEndpoints.movieDetailsEndpoint,
        {'imdb_id': movieId, 'with_images': 'true', 'with_cast': 'true'});
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    MovieDetailsModel data = MovieDetailsModel.fromJson(jsonResponse);
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movie;
    } else {
      throw data.statusMessage ?? 'Something went wrong';
    }
  }

  static Future<List<Movies>?> getMovieSuggestions(String movieId) async {
    Uri uri = Uri.https(
        AppConstants.moviesBaseUrl, AppEndpoints.movieSuggestionsEndpoint, {
      'movie_id': movieId,
    });
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    MoviesListResponse data = MoviesListResponse.fromJson(jsonResponse);
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movies;
    } else {
      throw data.statusMessage ?? 'Something went wrong';
    }
  }
}
