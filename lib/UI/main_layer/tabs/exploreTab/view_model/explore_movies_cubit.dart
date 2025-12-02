import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import '../model/explore_movies_api.dart';

abstract class ExploreMoviesState {}

class ExploreMoviesInitial extends ExploreMoviesState {}

class ExploreMoviesLoading extends ExploreMoviesState {}

class GetMoreMoviesLoadingState extends ExploreMoviesState {}

class ExploreMoviesLoaded extends ExploreMoviesState {
  final List<Movies> movies;

  ExploreMoviesLoaded(this.movies);
}

class ExploreMoviesEmpty extends ExploreMoviesState {}

class ExploreMoviesError extends ExploreMoviesState {
  final String message;

  ExploreMoviesError(this.message);
}

class ExploreMoviesCubit extends Cubit<ExploreMoviesState> {
  final ScrollController scrollController = ScrollController();
  int page = 1;
  List<Movies> movies = [];
  String selectedGenre = 'Action'; // Default genre
  ExploreMoviesCubit() : super(ExploreMoviesInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool atTop = scrollController.position.pixels == 0;
        if (!atTop && state is! GetMoreMoviesLoadingState) {
          page++;
          emit(GetMoreMoviesLoadingState());
          fetchMovies(selectedGenre);
        }
      }
    });
  }

  Future<void> fetchMovies(String genre) async {
    selectedGenre = genre;

    if (movies.isEmpty) {
      emit(ExploreMoviesLoading());
    }

    try {
      final newMovies = await ExploreMoviesApi.getMoviesByGenre(genre, page);
      movies.addAll(newMovies ?? []);
      if (movies.isEmpty) {
        emit(ExploreMoviesEmpty());
        return;
      }
      emit(ExploreMoviesLoaded(movies));
    } catch (e) {
      emit(ExploreMoviesError(e.toString()));
    }
  }
}
