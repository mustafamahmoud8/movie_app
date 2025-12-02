import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/utils/app_assets.dart';
import '../../../../../../../movieDetails/model/movie_details_model.dart';
import '../../../../../../../widgets/movie_card.dart';
import '../../../../view_model/providers/profile_tab_provider.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<MovieDetails>? allWatchedMovies =
        context.watch<ProfileTabProvider>().watchedMovies;
    return allWatchedMovies?.isEmpty == true || allWatchedMovies == null
        ? Center(
            child: Image.asset(
              AppAssets.emptyList,
              height: 124.h,
              width: 124.w,
            ),
          )
        : GridView.builder(
            itemCount: allWatchedMovies.length,
            padding: EdgeInsets.symmetric(horizontal: 16.r)
                .copyWith(top: 24.r, bottom: 90.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 122.w / 180.h,
                mainAxisSpacing: 16.4.r,
                crossAxisSpacing: 16.r),
            itemBuilder: (context, index) {
              return MovieCard(
                imagePath: allWatchedMovies[index].largeCoverImage ?? '',
                movieId: allWatchedMovies[index].imdbCode,
                rating: allWatchedMovies[index].rating,
              );
            },
          );
  }
}
