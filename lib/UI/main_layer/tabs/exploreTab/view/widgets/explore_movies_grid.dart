import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/widgets/movie_card.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';

import '../../view_model/explore_movies_cubit.dart';

class ExploreMoviesGrid extends StatelessWidget {
  final ExploreMoviesCubit exploreCubit;

  const ExploreMoviesGrid({super.key, required this.exploreCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: exploreCubit,
      child: BlocBuilder<ExploreMoviesCubit, ExploreMoviesState>(
        builder: (context, state) {
          if (state is ExploreMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.amber),
            );
          } else if (state is ExploreMoviesError) {
            return Center(child: Text(state.message));
          } else if (state is ExploreMoviesLoaded ||
              state is GetMoreMoviesLoadingState) {
            final List<Movies> movies =
                context.watch<ExploreMoviesCubit>().movies;
            return GridView.builder(
              controller: context.watch<ExploreMoviesCubit>().scrollController,
              itemCount:
                  movies.length + (state is GetMoreMoviesLoadingState ? 1 : 0),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemBuilder: (context, index) {
                if (state is GetMoreMoviesLoadingState &&
                    index == movies.length) {
                  return Padding(
                    padding:  EdgeInsets.all(16.r),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.amber,
                      ),
                    ),
                  );
                }
                return MovieCard(
                  movieId: movies[index].imdbCode,
                  imagePath: movies[index].mediumCoverImage ?? '',
                  rating: movies[index].rating,
                );
              },
            );
          } else {
            return Center(
                child: Text(
              'No Movies Found',
              style:
                  CustomTextStyles.style20w600.copyWith(color: AppColors.white),
            ));
          }
        },
      ),
    );
  }
}
