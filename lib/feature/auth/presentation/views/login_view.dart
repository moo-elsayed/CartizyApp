import 'package:cartizy_app_nti/core/helpers/dependency_injection.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/core/widgets/app_toasts.dart';
import 'package:cartizy_app_nti/core/widgets/custom_material_button.dart';
import 'package:cartizy_app_nti/feature/auth/data/repos/auth_repo_imp.dart';
import 'package:cartizy_app_nti/feature/auth/domain/entities/request/login_request_entity.dart';
import 'package:cartizy_app_nti/feature/auth/presentation/managers/login_cubit/login_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/helpers/validator.dart';
import '../../../../core/widgets/text_form_field_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.loginArgs});

  final LoginRequestEntity? loginArgs;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  var loginCubit = LoginCubit(getIt.get<AuthRepoImp>());

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _formKey = GlobalKey<FormState>();
    setState(() {});
  }

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
                  BlocConsumer<LoginCubit, LoginState>(
                    bloc: loginCubit,
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        AppToast.showToast(
                          context: context,
                          title: 'welcome',
                          type: ToastificationType.success,
                        );
                        SharedPreferencesManager.setUserLoggedIn(true);
                        context.pushReplacementNamed(Routes.appSection);
                      } else if (state is LoginFailure) {
                        AppToast.showToast(
                          context: context,
                          title: 'Error',
                          description: state.message,
                          type: ToastificationType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomMaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginCubit.login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        text: 'Login',
                        maxWidth: true,
                        textStyle: TextStylesManager.font16WhiteMedium,
                        color: ColorsManager.color212121,
                        padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
                        borderRadius: BorderRadius.circular(8.r),
                        isLoading: state is LoginLoading,
                      );
                    },
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
                  ..onTap = () async {
                    final result = await context.pushNamed(Routes.registerView);
                    if (result != null && result is LoginRequestEntity) {
                      _emailController.text = result.email;
                      _passwordController.text = result.password;
                    } else {
                      _clearForm();
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
