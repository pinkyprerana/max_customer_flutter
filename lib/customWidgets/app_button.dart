import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';
import '../core/utils/common_util.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Widget? child;
  final Color? color;
  final Color? textColor;
  final bool loading;
  final bool disable;
  final double? width;
  final double? height;
  final double radius;

  const AppButton({
    super.key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.disable = false,
    this.child,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.radius = 13,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // hoverColor: Colors.transparent,
      // focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? AppColors.colorPrimary,
        ),
        alignment: Alignment.center,
        child: loading
            ? loader()
            : child ??
            Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: AppTextStyles.textStylePoppinsBold.copyWith(
                fontSize: 15.sp,
                color: textColor ?? AppColors.colorWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
    );
  }
}
