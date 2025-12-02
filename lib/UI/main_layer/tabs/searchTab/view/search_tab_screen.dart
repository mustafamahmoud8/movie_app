import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view_model/search_movies_cubit.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view_model/search_movies_state.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view/widgets/custom_search_field.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import '../../../../widgets/movie_card.dart';

class SearchTabScreen extends StatefulWidget {
  const SearchTabScreen({super.key});

  @override
  State<SearchTabScreen> createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  bool hasSearched = false;

  @override
  void initState() {
    super.initState();
  }

  void _onSearch(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        hasSearched = false;
      });
    } else {
      setState(() {
        hasSearched = true;
        context.read<SearchMoviesCubit>().movies = [];
      });
      context.read<SearchMoviesCubit>().searchMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: Column(
            children: [
              CustomSearchField(
                onChanged: _onSearch,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
                  builder: (context, state) {
                    if (!hasSearched) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 300.h),
                            Center(
                              child: Image.asset(
                                AppAssets.empty,
                                width: 110.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.amber,
                        ),
                      );
                    } else if (state is SearchError) {
                      return Center(child: Text(state.message));
                    } else if (state is SearchEmpty) {
                      return Center(
                        child: Image.asset(
                          AppAssets.empty,
                          width: 124.w,
                          fit: BoxFit.contain,
                        ),
                      );
                    } else if (state is SearchSuccess ||
                        state is GetMoreMoviesLoadingState) {
                      final List<Movies> movies =
                          context.watch<SearchMoviesCubit>().movies;
                      return GridView.builder(
                        controller:
                            context.read<SearchMoviesCubit>().scrollController,
                        itemCount: movies.length +
                            (state is GetMoreMoviesLoadingState ? 1 : 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                        ),
                        itemBuilder: (context, index) {
                          if (state is GetMoreMoviesLoadingState &&
                              index == movies.length) {
                            return Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.amber,
                                ),
                              ),
                            );
                          }
                          final movie = movies[index];
                          return MovieCard(
                            movieId: movie.imdbCode,
                            imagePath: movie.mediumCoverImage ?? '',
                            rating: movie.rating,
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
