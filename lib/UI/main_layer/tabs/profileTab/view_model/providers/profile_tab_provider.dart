import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_prefs.dart';

import '../../../../../movieDetails/model/movie_details_model.dart';
import '../../model/models/get_favourite_movies_response_model.dart';
import '../../model/models/profile_response_model.dart';
import '../../model/network/profile_api.dart';
import '../../model/network/watch_list_and_history_movies_api.dart';

class ProfileTabProvider extends ChangeNotifier {
  bool loading = false;
  String? errorMessage;

  //watch list and history tabs
  List<FavouriteMovie>? favouriteMovies;
  List<MovieDetails>? watchedMovies;

  //update profile screen
  ProfileData? profileData;

  // ---------- all ----------
  Future<void> initialize(BuildContext context) async {
    try {
      loading = true;
      errorMessage = null;
      notifyListeners();

      final results = await Future.wait([
        getProfileData(context),
        getWatchListMovies(context),
        getHistoryMovies(),
      ]);

      profileData = results[0] as ProfileData?;
      favouriteMovies = results[1] as List<FavouriteMovie>?;
      watchedMovies = results[2] as List<MovieDetails>?;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // ---------- watch‑list ----------
  Future<void> addToWatchList(BuildContext context, MovieDetails? movie) async {
    await WatchListAndHistoryMoviesApi.postWatchListMovies(
        context: context,
        movieId: movie?.imdbCode ?? '',
        name: movie?.title ?? '',
        rating: movie?.rating ?? 0.0,
        imageURL: movie?.largeCoverImage ?? '',
        year: movie?.year.toString() ?? 0.toString());
  }

  Future<void> removeFromWatchList(BuildContext context, String movieId) async {
    await WatchListAndHistoryMoviesApi.removeMovieFromFav(movieId, context);
  }

  Future<List<FavouriteMovie>?> getWatchListMovies(BuildContext context) async {
    favouriteMovies =
        await WatchListAndHistoryMoviesApi.getWatchListMovies(context: context);
    return favouriteMovies;
  }

  // ---------- history ----------
  Future<List<MovieDetails>?> getHistoryMovies() async {
    watchedMovies = await AppPrefs.historyGetSetOfString();
    return watchedMovies;
  }

//update profile screen
  Future<ProfileData?> getProfileData(BuildContext context) async {
    profileData = await ProfileApi.getProfile(context);
    return profileData;
  }
}
