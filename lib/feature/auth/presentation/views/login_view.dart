import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/core/widgets/custom_material_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/helpers/validator.dart';
import '../../../../core/widgets/text_form_field_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.colorEBEBEB,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: TextStylesManager.font22color212121SemiBold,
                    ),
                  ),
                  Gap(38.h),
                  Text(
                    'Email',
                    style: TextStylesManager.font18color212121Regular,
                  ),
                  Gap(8.h),
                  TextFormFieldHelper(
                    controller: _emailController,
                    onValidate: Validator.validateEmail,
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  Gap(32.h),
                  Text(
                    'Password',
                    style: TextStylesManager.font18color212121Regular,
                  ),
                  Gap(8.h),
                  TextFormFieldHelper(
                    controller: _passwordController,
                    onValidate: Validator.validatePassword,
                    hint: 'Enter your password',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    action: TextInputAction.done,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  Gap(60.h),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    text: 'Login',
                    maxWidth: true,
                    textStyle: TextStylesManager.font16WhiteMedium,
                    color: ColorsManager.color212121,
                    padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(bottom: 36.h),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStylesManager.font14color212121Regular,
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStylesManager.font14color212121Bold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.pushNamed(Routes.registerView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
