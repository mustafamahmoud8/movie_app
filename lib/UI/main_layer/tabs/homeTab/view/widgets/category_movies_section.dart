import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/widgets/movie_card.dart';
import '../../../../../../core/utils/app_colors.dart';

class CategoryMoviesSection extends StatelessWidget {
  final List<Movies> movies;

  const CategoryMoviesSection({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 16.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150.w,
                height: 220.h,
                child: MovieCard(
                  movieId: movie.imdbCode,
                  imagePath: movie.largeCoverImage ?? '',
                  rating: movie.rating,
                ),
              ),
              SizedBox(
                width: 130.w,
                child: Text(
                  movie.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Roboto'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
