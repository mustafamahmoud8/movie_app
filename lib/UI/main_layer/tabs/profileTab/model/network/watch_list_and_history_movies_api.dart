import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/app_endpoints.dart';
import '../../../../../auth/view_model/providers/token_provider.dart';
import '../../../../../movieDetails/model/movie_added_to_fav_response.dart';
import '../models/get_favourite_movies_response_model.dart';

class WatchListAndHistoryMoviesApi {
  static final String baseUrl = "https://route-movie-apis.vercel.app";

  static Future<Map<String, dynamic>> postWatchListMovies({
    required BuildContext context,
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    final String? token = context.read<TokenProvider>().token;
    Uri uri = Uri.parse('$baseUrl/favorites/add');
    http.Response response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "movieId": movieId,
        "name": name,
        "rating": rating,
        'imageURL': imageURL,
        'year': year,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Request failed');
    }
  }

  static Future<List<FavouriteMovie>?> getWatchListMovies({
    required BuildContext context,
  }) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.parse('$baseUrl/favorites/all');
    http.Response response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    GetFavouriteMoviesResponseModel data =
        GetFavouriteMoviesResponseModel.fromJson(jsonResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data.data;
    } else {
      throw data.message ?? 'something went wrong';
    }
  }

  static Future<String> removeMovieFromFav(
      String movieId, BuildContext context) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.https(AppConstants.moviesAddDeleteBaseUrl,
        '${AppEndpoints.movieFavDeleteEndpoint}$movieId');
    final response = await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
    var jsonResponse = jsonDecode(response.body);
    MovieAddedToFavResponse responseMessage =
        MovieAddedToFavResponse.fromJson(jsonResponse);
    if (response.statusCode == 200 || response.statusCode == 404) {
      return responseMessage.message ?? 'something went wrong';
    } else {
      throw responseMessage.message ?? 'something Wrong';
    }
  }

  static Future<bool> movieIsFav(String movieID, BuildContext context) async {
    final String? token = context.read<TokenProvider>().token;

    Uri uri = Uri.https(
      AppConstants.moviesAddDeleteBaseUrl,
      '${AppEndpoints.movieIsFavEndpoint}$movieID',
    );
    var response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
    var jsonResponse = jsonDecode(response.body);
    bool dataValue = jsonResponse['data'] as bool;
    print(dataValue);
    return dataValue;
  }
}
