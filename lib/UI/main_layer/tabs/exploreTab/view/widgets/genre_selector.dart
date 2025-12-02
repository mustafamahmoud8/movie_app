import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/provider/selected_cat_provider.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/genre_translator.dart';
import 'package:provider/provider.dart';

class GenreSelector extends StatelessWidget {
  final List<String> genres;
  final int selectedIndex;
  final void Function(int) onGenreSelected;

  const GenreSelector({
    super.key,
    required this.genres,
    required this.selectedIndex,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.builder(
        controller: context.watch<SelectedCatProvider>().scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        padding:  EdgeInsets.symmetric(horizontal: 12.h),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onGenreSelected(index),
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal: 6.h),
              padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.amber : AppColors.black1,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.amber,
                  width: 1.5.w,
                ),
              ),
              child: Center(
                child: Text(
                  genres[index].getGenreLocalizedName(context),
                  style: TextStyle(
                    color: isSelected ? AppColors.black1 : AppColors.amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
