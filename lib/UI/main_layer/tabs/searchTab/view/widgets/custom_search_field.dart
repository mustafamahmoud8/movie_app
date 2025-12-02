import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view_model/search_movies_cubit.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final void Function(String) onChanged;

  const CustomSearchField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(AppAssets.searchIcon),
            color: AppColors.white,
            size: 24.sp,
          ),
           SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: context.read<SearchMoviesCubit>().searchController,
              onChanged: onChanged,
              cursorColor: AppColors.white,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: context.getLocalization().search,
                hintStyle: const TextStyle(color: AppColors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
