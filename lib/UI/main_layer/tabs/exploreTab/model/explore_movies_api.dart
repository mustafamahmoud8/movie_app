import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/utils/app_constants.dart';
import 'package:movies_app/core/utils/app_endpoints.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';

class ExploreMoviesApi {
  static Future<List<Movies>?> getMoviesByGenre(String genre, int page) async {
    Uri uri = Uri.https(
      AppConstants.moviesBaseUrl,
      AppEndpoints.listMoviesEndpoint,
      {
        'genre': genre,
        'sort_by': 'date_added',
        'page': page.toString(),
      },
    );
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    MoviesListResponse data = MoviesListResponse.fromJson(jsonResponse);
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.data?.movies ?? [];
    } else {
      throw data.statusMessage!;
    }
  }
}
