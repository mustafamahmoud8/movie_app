import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/UI/auth/view/screens/signInScreen.dart';
import 'package:movies_app/UI/auth/view_model/providers/token_provider.dart';
import 'package:movies_app/UI/main_layer/main_layer_screen.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/models/avatar_bottom_sheet_model.dart';
import '../../../model/models/profile_response_model.dart';
import '../../../view_model/providers/profile_tab_provider.dart';
import '../../screens/update_profile_screen.dart';

class ProfileTabHeader extends StatefulWidget {
  final TabController controller;
  final ProfileData? profileData;

  const ProfileTabHeader(
      {super.key, required this.controller, required this.profileData});

  @override
  State<ProfileTabHeader> createState() => _ProfileTabHeaderState();
}

class _ProfileTabHeaderState extends State<ProfileTabHeader> {
  @override
  Widget build(BuildContext context) {
    log('Avatar path: ${AvatarBottomSheetModel.avatarImages[widget.profileData?.avaterId ?? 7].avatarImage}');
    return Container(
      decoration: BoxDecoration(color: AppColors.black2),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14.r, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AvatarBottomSheetModel
                            .avatarImages[widget.profileData?.avaterId ?? 7]
                            .avatarImage,
                        height: 118.h,
                        width: 118.w,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      SizedBox(
                        width: 118.w,
                        child: Text(
                          widget.profileData?.name != null
                              ? (widget.profileData?.name)!
                                  .split(' ')
                                  .take(2)
                                  .join(' ')
                                  .substring(0)
                                  .toUpperCase()
                              : context.getLocalization().userName,
                          style: CustomTextStyles.style20w700.copyWith(
                              color: AppColors.white, fontFamily: 'Roboto'),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${context.watch<ProfileTabProvider>().favouriteMovies?.length ?? 0}',
                        style: CustomTextStyles.style36w500.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        context.getLocalization().watchList,
                        style: CustomTextStyles.style24w700.copyWith(
                            color: AppColors.white, fontFamily: 'Roboto'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${context.watch<ProfileTabProvider>().watchedMovies?.length ?? 0}',
                        style: CustomTextStyles.style36w500.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        context.getLocalization().history,
                        style: CustomTextStyles.style24w700.copyWith(
                            color: AppColors.white, fontFamily: 'Roboto'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 22.r),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: FilledButton(
                      onPressed: () async {
                        log(context.read<TokenProvider>().token.toString());
                        Navigator.of(context).pushNamed(
                            UpdateProfileScreen.routeName,
                            arguments: widget.profileData);
                      },
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          minimumSize: Size(252.w, 56.h),
                          backgroundColor: AppColors.yellow),
                      child: Text(
                        context.getLocalization().editProfile,
                        style: CustomTextStyles.style20w400.copyWith(
                            color: AppColors.black1, fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    flex: 3,
                    child: FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (context) => AlertDialog(
                            title: Text(
                              context.getLocalization().exit,
                              style: CustomTextStyles.style36w500
                                  .copyWith(color: AppColors.red),
                            ),
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            alignment: Alignment.center,
                            actionsAlignment: MainAxisAlignment.center,
                            content: Text(
                              context.getLocalization().areYouSureYouWantToExit,
                              style: CustomTextStyles.style20w600
                                  .copyWith(color: AppColors.black1),
                              textAlign: TextAlign.center,
                            ),
                            icon: Icon(
                              Icons.exit_to_app_rounded,
                              color: AppColors.red,
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.yellow,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      context.getLocalization().no,
                                      style: CustomTextStyles.style20w600
                                          .copyWith(color: AppColors.black1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      context.read<TokenProvider>().token =
                                          null;
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        SignInScreen.routeName,
                                        (route) => false,
                                      );
                                      currentIndex.value = 0;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      context.getLocalization().yes,
                                      style: CustomTextStyles.style20w600
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          minimumSize: Size(134.w, 56.h),
                          backgroundColor: AppColors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.getLocalization().exit,
                            style: CustomTextStyles.style20w400.copyWith(
                                color: AppColors.white, fontFamily: 'Roboto'),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            AppAssets.exitIcon,
                            height: 18.h,
                            width: 16.4.w,
                            matchTextDirection: true,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
