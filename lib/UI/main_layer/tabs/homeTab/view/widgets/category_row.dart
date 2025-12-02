import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/main_layer/main_layer_screen.dart';
import 'package:movies_app/UI/main_layer/provider/selected_cat_provider.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto'),
          ),
          InkWell(
            onTap: () {
              context.read<SelectedCatProvider>().selectCat(
                    title,
                  );
              currentIndex.value = 2;
            },
            child: Row(
              children: [
                Text(
                  context.getLocalization().seeMore,
                  style: TextStyle(
                      color: AppColors.amber,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto'),
                ),
                 SizedBox(width: 4.w),
                 Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: AppColors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
