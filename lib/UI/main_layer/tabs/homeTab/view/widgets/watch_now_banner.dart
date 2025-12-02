import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_assets.dart';

class WatchNowBanner extends StatelessWidget {
  const WatchNowBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Image.asset(
        AppAssets.watchNow,
        width: 354.w,
        // height: 80,
        fit: BoxFit.contain,
      ),
    );
  }
}
