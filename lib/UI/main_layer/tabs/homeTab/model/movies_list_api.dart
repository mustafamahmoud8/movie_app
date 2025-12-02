import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/core/utils/app_constants.dart';
import 'package:movies_app/core/utils/app_endpoints.dart';

class MoviesListApi {
  static Future<List<Movies>?> getListMoviesByDate() async {
    Uri uri = Uri.https(AppConstants.moviesBaseUrl,
        AppEndpoints.listMoviesEndpoint, {'sort_by': 'date_added'});
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    MoviesListResponse data = MoviesListResponse.fromJson(jsonResponse);
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movies ?? [];
    } else {
      throw data.statusMessage!;
    }
  }

  static Future<List<Movies>?> getListMoviesByGener(String gener) async {
    Uri uri =
        Uri.https(AppConstants.moviesBaseUrl, AppEndpoints.listMoviesEndpoint, {
      'genre': gener,
      'limit': '3',
      'sort_by': 'date_added',
    });
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    MoviesListResponse data = MoviesListResponse.fromJson(jsonResponse);
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movies ?? [];
    } else {
      throw data.statusMessage!;
    }
  }

  static Future<List<Movies>?> getMoviesByQuery(String query, int page) async {
    Uri uri = Uri.https(
      AppConstants.moviesBaseUrl,
      AppEndpoints.listMoviesEndpoint,
      {
        'query_term': query,
        'sort_by': 'date_added',
        'page': page.toString(),
      },
    );

    final response = await http.get(uri);
    final jsonResponse = jsonDecode(response.body);
    final MoviesListResponse data = MoviesListResponse.fromJson(jsonResponse);

    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movies ?? [];
    } else {
      throw data.statusMessage ?? 'Unknown error';
    }
  }
}
