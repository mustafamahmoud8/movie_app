import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view_model/moviesListByGenerCubit/get_movie_list_cubit.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view_model/moviesListByGenerCubit/get_movie_list_cubit_states.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view/widgets/available_now_section.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view/widgets/category_movies_section.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view/widgets/category_row.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/genre_translator.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> geners = [
      'Action',
      'Adventure',
      'Animation',
      'Biography',
      'Comedy',
      'Crime',
      'Documentary',
      'Drama',
      'Family',
      'Fantasy',
      'Film-Noir',
      'Game-Show',
      'History',
      'Horror',
      'Music',
      'Musical',
      'Mystery',
      'News',
      'Reality-TV',
      'Romance',
      'Sci-Fi',
      'Short',
      'Sport',
      'Talk-Show',
      'Thriller',
      'War',
      'Western'
    ];
    List<String> selectedCategories = chooseRandomUniqueCategories(geners, 3);

    return BlocProvider(
      create: (context) => GetMoviesCubit(),
      child: BlocBuilder<GetMoviesCubit, GetMovieListCubitStates>(
          bloc: GetMoviesCubit()
            ..getMoviesListByGener(selectedCategories[0], selectedCategories[1],
                selectedCategories[2]),
          builder: (context, state) {
            switch (state) {
              case GetMovieListInitialState():
              case GetMovieListLoadingState():
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.amber,
                        ),
                      ),
                    ]);
              case GetMovieListFailureState():
                return Center(
                  child: Text('${state.message}'),
                );

              case GetMovieListEmptyListState():
                return Center(
                  child: Text('No Movies'),
                );
              case GetMovieListSuccessState():
                List<Movies> availableMowSection =
                    state.availableNowSection ?? [];
                final List<Movies> moviesSection1 = state.moviesSection1!;
                final List<Movies> moviesSection2 = state.moviesSection2!;
                final List<Movies> moviesSection3 = state.moviesSection3!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AvailableNowSection(
                            movies: availableMowSection,
                          ),
                          Center(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 24.0.w, vertical: 20.h),
                              child: Image.asset(
                                AppAssets.availableNow,
                                width: 267.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: 24.h),
                      Column(
                        children: [
                          CategoryRow(
                              title: selectedCategories[0]
                                  .getGenreLocalizedName(context)),
                          CategoryMoviesSection(movies: moviesSection1),
                          CategoryRow(
                              title: selectedCategories[1]
                                  .getGenreLocalizedName(context)),
                          CategoryMoviesSection(movies: moviesSection2),
                          CategoryRow(
                              title: selectedCategories[2]
                                  .getGenreLocalizedName(context)),
                          CategoryMoviesSection(movies: moviesSection3),
                           SizedBox(height: 60.h),
                        ],
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }

  List<String> chooseRandomUniqueCategories(List<String> genres, int count) {
    genres.shuffle();
    return genres.take(count).toList();
  }
}
