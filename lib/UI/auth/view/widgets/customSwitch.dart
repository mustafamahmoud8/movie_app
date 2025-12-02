import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movies_app/UI/auth/view_model/providers/switch_provider.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatelessWidget {
  final String inactiveIcon;
  final String activeIcon;

  const CustomSwitch({
    super.key,
    required this.inactiveIcon,
    required this.activeIcon,
  });

  @override
  Widget build(BuildContext context) {
    final switchProvider = context.watch<SwitchProvider>();

    return FlutterSwitch(
      width: 80.w,
      height: 40.h,
      toggleSize: 36.w,
      activeToggleColor: AppColors.yellow,
      inactiveToggleColor: AppColors.yellow,
      value: switchProvider.isActive,
      borderRadius: 30.0.r,
      toggleColor: Colors.transparent,
      padding: 2.0.r,
      activeColor: AppColors.yellow,
      inactiveColor: AppColors.grey,
      showOnOff: false,
      inactiveIcon: Image.asset(
        inactiveIcon,
        width: 38.w,
        height: 38.h,
        fit: BoxFit.cover,
      ),
      activeIcon: Image.asset(
        activeIcon,
        width: 38.w,
        height: 38.h,
        fit: BoxFit.cover,
      ),
      onToggle: (val) {
        switchProvider.toggleSwitch(val);
      },
    );
  }
}
