import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';

sealed class GetMovieListCubitStates {}

class GetMovieListInitialState extends GetMovieListCubitStates {}

class GetMovieListLoadingState extends GetMovieListCubitStates {}

class GetMovieListFailureState extends GetMovieListCubitStates {
  final String? message;

  GetMovieListFailureState({required this.message});
}

class GetMovieListSuccessState extends GetMovieListCubitStates {
  final List<Movies>? moviesSection1;
  final List<Movies>? moviesSection2;
  final List<Movies>? moviesSection3;
  final List<Movies>? availableNowSection;

  GetMovieListSuccessState(
      {required this.moviesSection1,
      required this.moviesSection2,
      required this.moviesSection3,
      required this.availableNowSection});
}

class GetMovieListEmptyListState extends GetMovieListCubitStates {
  final List<Movies>? availableNowSection = [];
  final List<Movies>? moviesSection1 = [];
  final List<Movies>? moviesSection2 = [];
  final List<Movies>? moviesSection3 = [];
}
