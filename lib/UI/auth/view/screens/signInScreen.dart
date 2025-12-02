import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/UI/auth/model/AuthService%20.dart';
import 'package:movies_app/UI/auth/view/screens/signUpScreen.dart';
import 'package:movies_app/UI/auth/view/widgets/customSwitch.dart';
import 'package:movies_app/UI/auth/view/widgets/customTextFormField.dart';
import 'package:movies_app/UI/main_layer/main_layer_screen.dart';
import 'package:movies_app/UI/widgets/custom_elevated_button_filled.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';
import 'package:movies_app/generated/l10n.dart';

import '../../view_model/cubit/auth_cubit.dart';
import '../../view_model/cubit/auth_state.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/Signinscreen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 28.h),
                    Image(
                      image: AssetImage(AppAssets.signinLogo),
                      width: 121.w,
                      height: 118.h,
                    ),
                    SizedBox(height: 69.h),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        context.getLocalization().forgetPassword,
                        style: CustomTextStyles.style14w400.copyWith(
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(height: 34.h),
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
                          Navigator.pushReplacementNamed(
                              context, MainLayerScreen.routeName);
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
                          buttonText: context.getLocalization().login,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                    emailController.text.trim().toLowerCase(),
                                    passwordController.text.trim(),
                                    context,
                                  );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 23.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: context.getLocalization().donotHaveAccount),
                          TextSpan(
                            style: CustomTextStyles.style14w400.copyWith(
                              color: AppColors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                            text: context.getLocalization().createOne,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                    context,
                                    SignUpScreen.routeName,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 27.h),
                    Row(
                      children: [
                        Expanded(child: Divider(indent: 75.r)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Text(
                            S.of(context).or,
                            style: CustomTextStyles.style16w400.copyWith(
                              color: AppColors.yellow,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(endIndent: 75.r)),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    CustomElevatedButtonFilled(
                      isSingInPage: true,
                      buttonText: context.getLocalization().loginWithGoogle,
                      onPressed: () {
                        context.read<AuthCubit>().loginWithGoogle(context);
                      },
                    ),
                    SizedBox(height: 33.h),
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
      }),
    );
  }
}
