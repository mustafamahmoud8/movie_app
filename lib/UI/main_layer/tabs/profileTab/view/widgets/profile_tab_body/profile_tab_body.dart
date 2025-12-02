import 'package:flutter/material.dart';
import 'package:movies_app/UI/main_layer/tabs/profileTab/view/widgets/profile_tab_body/widgets/history_tab.dart';
import 'package:movies_app/UI/main_layer/tabs/profileTab/view/widgets/profile_tab_body/widgets/watch_list_tab.dart';

import '../../../../../../movieDetails/model/movie_details_model.dart';
import '../../../model/models/get_favourite_movies_response_model.dart';

class ProfileTabBody extends StatelessWidget {
  final TabController controller;
  final List<FavouriteMovie>? favouriteMovies;
  final List<MovieDetails>? allWatchedMovies;

  const ProfileTabBody(
      {super.key,
      required this.controller,
      required this.favouriteMovies,
      this.allWatchedMovies});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        WatchListTab(),
        HistoryTab(),
      ],
    );
  }
}
