import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_customer/core/routes/app_router.dart';
import 'package:max_customer/customWidgets/toast.dart';
import '../blocs/auth_bloc.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';
import '../core/utils/app_consts.dart';
import '../core/utils/app_images.dart';
import '../core/utils/common_util.dart';
import '../customWidgets/app_button.dart';
import '../customWidgets/custom_input_field.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.22.sh,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0).r,
                    child: Center(
                      child: Text(AppConstants.appName,
                          style: AppTextStyles.textStylePoppinsSemiBold.copyWith(
                            color: AppColors.colorPrimary,
                            fontSize: 24.sp,
                          )),
                    ),
                  ),
                ),
            Image.asset(AppImages.logo),
            20.verticalSpace,
            CustomInputField(
              label: 'Email',
              hint: 'Please Enter Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(passwordNode);
              },
            ),
            10.verticalSpace,
            CustomInputField(
              focusNode: passwordNode,
              controller: passwordController,
              label: 'Password',
              hint: 'Please Enter Password',
              isPassword: true,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) => dismissKeyboard(context),
            ),

            40.verticalSpace,
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.isAuthenticated) {
                      AutoRouter.of(context).pushAndPopUntil(const CustomerListRoute(), predicate: (_) => false);
                    } else if (state.error != null) {
                      showToastMessage(state.error!);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      onPressed: () {
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          showToastMessage("Please enter email and password!");
                          return;
                        }
                        context.read<AuthCubit>().login(emailController.text, passwordController.text);
                      },
                      text: "Login",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
