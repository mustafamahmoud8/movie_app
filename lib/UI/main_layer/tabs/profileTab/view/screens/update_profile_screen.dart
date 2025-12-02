import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/auth/view_model/providers/switch_provider.dart';
import 'package:movies_app/UI/main_layer/tabs/profileTab/view/screens/resetPassword.dart';
import 'package:movies_app/UI/widgets/avatar_bottom_sheet_icon.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/models/avatar_bottom_sheet_model.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/view/screens/signInScreen.dart';
import '../../../../../widgets/custom_elevated_button_filled.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../main_layer_screen.dart';
import '../../model/models/profile_response_model.dart';
import '../../model/network/profile_api.dart';
import '../../view_model/providers/avatar_bottom_sheet_provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/updateProfileScreen';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with TickerProviderStateMixin {
  ProfileData? profileData;

  TextEditingController? nameController;
  TextEditingController? phoneController;

  bool _initDone = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_initDone) return;
      _initDone = true;
      profileData = ModalRoute.of(context)!.settings.arguments as ProfileData;
      context
          .read<AvatarBottomSheetProvider>()
          .initialAvatar(avatarId: profileData?.avaterId);
      nameController = TextEditingController(text: profileData?.name ?? '');
      phoneController = TextEditingController(text: profileData?.phone ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_rounded, color: AppColors.yellow),
        ),
        title: Text(
          context.getLocalization().pickAvatar,
          style: CustomTextStyles.style16w400.copyWith(
            color: AppColors.yellow,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.r,
          right: 16.r,
          bottom: 34.r,
          top: 36.r,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  transitionAnimationController: AnimationController(
                    vsync: this,
                    duration: Duration(seconds: 1),
                    reverseDuration: Duration(seconds: 1),
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  context: context,
                  builder: (context) {
                    return TapRegion(
                      onTapOutside: (event) => Navigator.of(context).pop(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(18),
                            margin: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 18,
                                childAspectRatio: 108 / 105,
                              ),
                              itemBuilder: (context, index) {
                                return AvatarBottomSheetIcon(
                                  avatarImage: AvatarBottomSheetModel
                                      .avatarImages[index].avatarImage,
                                  index: index,
                                );
                              },
                              itemCount:
                                  AvatarBottomSheetModel.avatarImages.length,
                              shrinkWrap: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                context.watch<AvatarBottomSheetProvider>().selectedAvatar ??
                    AppAssets.avatarImage8,
                height: 150.h,
                width: 150.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 34.r, bottom: 20.r),
              child: CustomTextFormFieldOnboarding(
                hintText: context.getLocalization().nameHint,
                prefixIcon: AppAssets.personIcon,
                controller: nameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.r),
              child: CustomTextFormFieldOnboarding(
                hintText: context.getLocalization().phoneHint,
                prefixIcon: AppAssets.phoneIcon1,
                controller: phoneController,
              ),
            ),
            Align(
              alignment: context.watch<SwitchProvider>().isActive
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ResetPassword.routeName);
                },
                child: Text(
                  context.getLocalization().resetPassword,
                  style: CustomTextStyles.style20w400.copyWith(
                    color: AppColors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomElevatedButtonFilled(
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (context) => AlertDialog(
                      title: Text(
                        context.getLocalization().deleteAccount,
                        style: CustomTextStyles.style36w500
                            .copyWith(color: AppColors.red),
                      ),
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      alignment: Alignment.center,
                      actionsAlignment: MainAxisAlignment.center,
                      content: Text(
                        context.getLocalization().deleteAccountMessage,
                        style: CustomTextStyles.style20w600
                            .copyWith(color: AppColors.black1),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.red,
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
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
                                await ProfileApi.deleteProfile(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    context.getLocalization().profileDeleted,
                                    style: CustomTextStyles.style20w600
                                        .copyWith(color: AppColors.black1),
                                  ),
                                  backgroundColor: AppColors.yellow,
                                ));

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  SignInScreen.routeName,
                                  (route) => false,
                                );
                                currentIndex.value = 0;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
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
                buttonColor: AppColors.red,
                buttonTextWidget: Text(
                  context.getLocalization().deleteAccount,
                  style: CustomTextStyles.style20w400.copyWith(
                    color: AppColors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            CustomElevatedButtonFilled(
              onPressed: () async {
                context.read<AvatarBottomSheetProvider>().changeAvatarId();
                String name = nameController?.text.trim() ?? '';
                String phone = phoneController?.text.trim() ?? '';
                try {
                  await ProfileApi.updateProfile(context, name, phone);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        context.getLocalization().profileUpdated,
                        style: CustomTextStyles.style20w600
                            .copyWith(color: AppColors.black1),
                      ),
                      backgroundColor: AppColors.yellow,
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${context.getLocalization().profileUpdateFailed} $e",
                        style: CustomTextStyles.style20w600
                            .copyWith(color: AppColors.white),
                      ),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
              buttonTextWidget: Text(
                context.getLocalization().updateData,
                style: CustomTextStyles.style20w400.copyWith(
                  color: AppColors.black1,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
