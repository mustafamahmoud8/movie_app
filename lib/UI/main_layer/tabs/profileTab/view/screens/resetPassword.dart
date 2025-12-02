import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/auth/view/widgets/customTextFormField.dart';
import 'package:movies_app/UI/auth/view_model/providers/switch_provider.dart';
import 'package:movies_app/UI/widgets/custom_elevated_button_filled.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/utils/app_assets.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/custom_text_styles.dart';
import '../../model/network/profile_api.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = '/Forgetpassword';

  const ResetPassword({
    super.key,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        title: Text(
          context.getLocalization().resetPassword,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                width: 430.w,
                height: 430.h,
                child: Image(
                  image: AssetImage(AppAssets.forgetPassword),
                  fit: BoxFit.cover,
                ),
              ),
              CustomTextFormFieldAuth(
                hintText: context.getLocalization().oldPasswordHint,
                password: true,
                prefixIconPath: AppAssets.passwordIcon,
                controller: oldPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.getLocalization().passwordRequired;
                  }
                  if (value.length < 6) {
                    return context.getLocalization().passwordMinLength;
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return context.getLocalization().passwordUppercase;
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return context.getLocalization().passwordNumber;
                  }
                  if (!RegExp(r'[!@#\$&*~%^()\-_+=<>?/.,;:{}\[\]]')
                      .hasMatch(value)) {
                    return context.getLocalization().passwordSpecial;
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAuth(
                hintText: context.getLocalization().newPasswordHint,
                password: true,
                prefixIconPath: AppAssets.passwordIcon,
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.getLocalization().passwordRequired;
                  }
                  if (value.length < 6) {
                    return context.getLocalization().passwordMinLength;
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return context.getLocalization().passwordUppercase;
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return context.getLocalization().passwordNumber;
                  }
                  if (!RegExp(r'[!@#\$&*~%^()\-_+=<>?/.,;:{}\[\]]')
                      .hasMatch(value)) {
                    return context.getLocalization().passwordSpecial;
                  }
                  if (value == oldPasswordController.text) {
                    return context.getLocalization().passwordShouldNotMatch;
                  }
                  return null;
                },
              ),
              CustomElevatedButtonFilled(
                buttonText: context.getLocalization().changePassword,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      String responseMessage = await ProfileApi.resetPassword(
                          context,
                          oldPasswordController.text.trim(),
                          newPasswordController.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          context.read<SwitchProvider>().isActive
                              ? 'تم تحديث الملف الشخصي بنجاح'
                              : responseMessage,
                          style: CustomTextStyles.style20w600
                              .copyWith(color: AppColors.black1),
                        ),
                        backgroundColor: AppColors.yellow,
                      ));
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
