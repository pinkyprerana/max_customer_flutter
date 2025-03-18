import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    this.label,
    required this.hint,
    this.maxLength,
    this.width,
    this.controller,
    this.focusNode,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.validator,
    super.key,
  });

  final String? label;
  final String hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.colorGrey,
          alignLabelWithHint: true,
          labelText: widget.label,
          labelStyle: AppTextStyles.textStylePoppinsLight.copyWith(
            color: AppColors.colorPrimaryAlpha,
            fontSize: 11.sp,
          ),
          hintText: widget.hint,
          counterText: "",
          hintStyle: AppTextStyles.textStylePoppinsRegular.copyWith(
            color: AppColors.colorPrimaryAlpha,
          ),
          border: InputBorder.none,
          floatingLabelBehavior: widget.label != null
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.never,
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: () => setState(() {
              isPasswordVisible = !isPasswordVisible;
            }),
            child: Icon(
              isPasswordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.colorPrimaryAlpha,
            ),
          )
              : const Icon(
            Icons.text_fields_rounded,
            color: AppColors.colorTransparent,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && !isPasswordVisible,
        obscuringCharacter: '*',
        style: AppTextStyles.textStylePoppinsRegular.copyWith(fontSize: 13.sp),
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
      ),
    );
  }
}
