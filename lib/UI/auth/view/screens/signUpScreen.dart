import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/auth/model/AuthService%20.dart';
import 'package:movies_app/UI/auth/view_model/cubit/auth_cubit.dart';
import 'package:movies_app/UI/auth/view_model/cubit/auth_state.dart';
import 'package:movies_app/UI/auth/view/widgets/customSwitch.dart';
import 'package:movies_app/UI/auth/view/widgets/customTextFormField.dart';
import 'package:movies_app/UI/widgets/custom_elevated_button_filled.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/models/avatar_bottom_sheet_model.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/Signupscreen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  int selectedIndex = 7;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, size: 24.r)),
          title: Text(context.getLocalization().register),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      selectedIndex = index;
                    },
                    height: 161.h,
                    viewportFraction: 0.4,
                    initialPage: selectedIndex,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                  ),
                  items: List.generate(
                    AvatarBottomSheetModel.avatarImages.length,
                    (index) => index,
                  ).map((i) {
                    return Builder(
                      builder: (context) {
                        return Image(
                          image: AssetImage(
                            AvatarBottomSheetModel.avatarImages[i].avatarImage,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: Text(
                      context.getLocalization().avatar,
                      style: CustomTextStyles.style20w400
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                CustomTextFormFieldAuth(
                  hintText: context.getLocalization().nameHint,
                  password: false,
                  prefixIconPath: AppAssets.idIcon,
                  controller: nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? context.getLocalization().nameRequired
                      : null,
                ),
                CustomTextFormFieldAuth(
                  hintText: context.getLocalization().emailHint,
                  password: false,
                  prefixIconPath: AppAssets.emailIcon,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.getLocalization().emailRequired;
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                        .hasMatch(value)) {
                      return context.getLocalization().invalidEmail;
                    }
                    return null;
                  },
                ),
                CustomTextFormFieldAuth(
                  hintText: context.getLocalization().passwordHint,
                  password: true,
                  prefixIconPath: AppAssets.passwordIcon,
                  controller: passwordController,
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
                  hintText: context.getLocalization().confirmPasswordHint,
                  password: true,
                  prefixIconPath: AppAssets.passwordIcon,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.getLocalization().confirmPasswordRequired;
                    }
                    if (value != passwordController.text) {
                      return context.getLocalization().passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                CustomTextFormFieldAuth(
                  hintText: context.getLocalization().phoneHint,
                  password: false,
                  prefixIconPath: AppAssets.phoneIcon1,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.getLocalization().phoneRequired;
                    }
                    if (!value.startsWith('+')) {
                      return context.getLocalization().phoneStartWithPlus;
                    }
                    if (value.length != 13) {
                      return context.getLocalization().phoneExactLength;
                    }
                    if (!RegExp(r'^\+\d{12}$').hasMatch(value)) {
                      return context.getLocalization().phoneOnlyDigits;
                    }
                    return null;
                  },
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(
                            child: CircularProgressIndicator(
                          color: AppColors.yellow,
                        )),
                      );
                    } else {
                      Navigator.pop(context);
                    }

                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          style: CustomTextStyles.style20w600
                              .copyWith(color: AppColors.black1),
                        ),
                        backgroundColor: AppColors.yellow,
                      ));
                      Navigator.pop(context);
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          style: CustomTextStyles.style20w600
                              .copyWith(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.red,
                      ));
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButtonFilled(
                      buttonText: context.getLocalization().createAccount,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                                nameController.text.trim(),
                                emailController.text.trim().toLowerCase(),
                                passwordController.text.trim(),
                                confirmPasswordController.text.trim(),
                                phoneController.text.trim(),
                                selectedIndex,
                                context,
                              );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 18.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: context.getLocalization().alreadyHaveAccount),
                        TextSpan(
                          style: CustomTextStyles.style14w400.copyWith(
                            color: AppColors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                          text: context.getLocalization().login,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                CustomSwitch(
                  inactiveIcon: AppAssets.enIcon,
                  activeIcon: AppAssets.egIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
