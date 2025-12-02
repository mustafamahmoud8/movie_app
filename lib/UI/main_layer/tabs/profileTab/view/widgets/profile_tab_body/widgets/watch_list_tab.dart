import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/utils/app_assets.dart';
import '../../../../../../../widgets/movie_card.dart';
import '../../../../model/models/get_favourite_movies_response_model.dart';
import '../../../../view_model/providers/profile_tab_provider.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<FavouriteMovie>? favouriteMovies =
        context.watch<ProfileTabProvider>().favouriteMovies;
    return favouriteMovies?.isEmpty == true || favouriteMovies == null
        ? Center(
            child: Image.asset(
              AppAssets.emptyList,
              height: 124.h,
              width: 124.w,
            ),
          )
        : GridView.builder(
            itemCount: favouriteMovies.length,
            padding: EdgeInsets.symmetric(horizontal: 16.r)
                .copyWith(top: 24.r, bottom: 90.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 122.w / 180.h,
                mainAxisSpacing: 16.4.r,
                crossAxisSpacing: 16.r),
            itemBuilder: (context, index) {
              return MovieCard(
                imagePath: favouriteMovies[index].imageURL ?? '',
                movieId: favouriteMovies[index].movieId,
                rating: favouriteMovies[index].rating,
              );
            },
          );
  }
}
