import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';

class NameFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final String? label;
  final String? hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const NameFormField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.maxLength,
    this.label,
    this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  State<NameFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<NameFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allow only letters and spaces
      ],
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
    );
  }
}
