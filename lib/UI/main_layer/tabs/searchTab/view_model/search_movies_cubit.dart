import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_api.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  int page = 1;
  List<Movies> movies = [];
  SearchMoviesCubit() : super(SearchInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool atTop = scrollController.position.pixels == 0;
        if (!atTop && state is! GetMoreMoviesLoadingState) {
          page++;
          emit(GetMoreMoviesLoadingState());
          searchMovies();
        }
      }
    });
  }

  Future<void> searchMovies() async {
    if (searchController.text.trim().isEmpty) return;
    if (movies.isEmpty) {
      emit(SearchLoading());
    }
    try {
      final result =
          await MoviesListApi.getMoviesByQuery(searchController.text, page) ??
              [];

      movies.addAll(result);
      if (movies.isEmpty) {
        emit(SearchEmpty());
        return;
      }

      emit(SearchSuccess(result));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
