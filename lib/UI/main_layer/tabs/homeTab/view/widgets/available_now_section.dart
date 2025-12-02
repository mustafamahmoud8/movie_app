import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/widgets/movie_card.dart';

import '../../../../../../core/utils/app_colors.dart';
import 'watch_now_banner.dart';

class AvailableNowSection extends StatefulWidget {
  const AvailableNowSection({super.key, required this.movies});
  final List<Movies> movies;

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    String bgImage = widget.movies[_currentIndex].largeCoverImage!;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black1.withAlpha(204),
                AppColors.black1.withAlpha(153),
                AppColors.black1,
              ],
              stops: [0.3, 0.4, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.darken,
          child: Image.network(
            bgImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 100.h),
               SizedBox(height: 10.h),
              CarouselSlider.builder(
                itemCount: widget.movies.length,
                itemBuilder: (context, index, realIdx) {
                  final movie = widget.movies[index];
                  return MovieCard(
                    movieId: movie.imdbCode,
                    imagePath: movie.largeCoverImage ?? '',
                    rating: movie.rating,
                  );
                },
                options: CarouselOptions(
                  height: 350.h,
                  enlargeCenterPage: true,
                  viewportFraction: 0.6,
                  initialPage: _currentIndex,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                      bgImage = widget.movies[_currentIndex].largeCoverImage!;
                    });
                  },
                ),
              ),
               SizedBox(height: 10.h),
              const WatchNowBanner(),
            ],
          ),
        ),
      ],
    );
  }
}
