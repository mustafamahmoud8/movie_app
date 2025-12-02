import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_styles.dart';

class CustomTextFormFieldAuth extends StatefulWidget {
  const CustomTextFormFieldAuth(
      {super.key,
      required this.hintText,
      required this.password,
      required this.prefixIconPath,
      required this.controller,
      this.validator});

  final String hintText;
  final bool password;
  final String prefixIconPath;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormFieldAuth> createState() =>
      _CustomTextFormFieldAuthState();
}

class _CustomTextFormFieldAuthState extends State<CustomTextFormFieldAuth> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.r),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: widget.validator,
        style: CustomTextStyles.style20w400.copyWith(color: AppColors.white),
        cursorColor: AppColors.white,
        controller: widget.controller,
        obscureText: widget.password ? isObscure : false,
        decoration: InputDecoration(
          suffixIconColor: AppColors.white,
          hintStyle:
              CustomTextStyles.style16w400.copyWith(color: AppColors.white),
          fillColor: AppColors.grey,
          filled: true,
          hintText: widget.hintText,
          suffixIcon: widget.password == true
              ? GestureDetector(
                  onTap: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  child:
                      Icon(isObscure ? Icons.visibility_off : Icons.visibility))
              : null,
          prefixIcon: Padding(
            padding: EdgeInsets.all(10.r),
            child: SvgPicture.asset(
              widget.prefixIconPath,
              width: 25.w,
              height: 25.h,
              colorFilter: ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          border: customBorder(),
          enabledBorder: customBorder(),
          focusedBorder: customBorder(),
          disabledBorder: customBorder(),
          errorBorder: customBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    );
  }
}
