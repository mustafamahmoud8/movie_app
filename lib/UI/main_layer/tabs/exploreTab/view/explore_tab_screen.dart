import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/provider/selected_cat_provider.dart';
import 'package:movies_app/UI/main_layer/tabs/exploreTab/view/widgets/explore_movies_grid.dart';
import 'package:movies_app/UI/main_layer/tabs/exploreTab/view/widgets/genre_selector.dart';
import 'package:movies_app/core/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../view_model/explore_movies_cubit.dart';

class ExploreTabScreen extends StatefulWidget {
  const ExploreTabScreen({
    super.key,
  });

  @override
  State<ExploreTabScreen> createState() => _ExploreTabScreenState();
}

class _ExploreTabScreenState extends State<ExploreTabScreen>
    with AutomaticKeepAliveClientMixin {
  final genres = AppConstants.genresList;

  int selectedGenreIndex = 0;
  late ExploreMoviesCubit exploreCubit;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<SelectedCatProvider>(context, listen: false);
    selectedGenreIndex = provider.selectedCat;

    exploreCubit = ExploreMoviesCubit();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SelectedCatProvider>(
      builder: (context, value, child) {
        selectedGenreIndex = value.selectedCat;
        exploreCubit.selectedGenre = genres[selectedGenreIndex];
        exploreCubit.page = 1;
        exploreCubit.movies = [];

        exploreCubit.fetchMovies(genres[selectedGenreIndex]);
        return SafeArea(
          bottom: false,
          child: Column(
            children: [
               SizedBox(height: 12.h),
              GenreSelector(
                genres: genres,
                selectedIndex: selectedGenreIndex,
                onGenreSelected: (index) {
                  setState(() {
                    context.read<SelectedCatProvider>().selectedCat = index;
                  });
                },
              ),
               SizedBox(height: 16.h),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: BlocProvider.value(
                      value: exploreCubit,
                      child: ExploreMoviesGrid(exploreCubit: exploreCubit)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
