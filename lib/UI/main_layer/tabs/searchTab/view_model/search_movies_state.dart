import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';

abstract class SearchMoviesState {}

class SearchInitial extends SearchMoviesState {}

class SearchLoading extends SearchMoviesState {}

class SearchSuccess extends SearchMoviesState {
  final List<Movies> movies;

  SearchSuccess(this.movies);
}

class GetMoreMoviesLoadingState extends SearchMoviesState {}

class SearchEmpty extends SearchMoviesState {}

class SearchError extends SearchMoviesState {
  final String message;

  SearchError(this.message);
}
