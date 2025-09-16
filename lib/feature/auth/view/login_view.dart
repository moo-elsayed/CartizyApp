import 'package:cartizy_app_nti/feature/auth/view/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/validator.dart';
import '../../../core/widgets/text_form_field_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = "LoginScreen";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Email",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            TextFormFieldHelper(
              controller: emailController,
              onValidate: Validator.validateEmail,
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            const SizedBox(height: 30),
            const Text(
              "Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            TextFormFieldHelper(
              controller: passwordController,
              onValidate: Validator.validatePassword,
              hint: 'Enter your password',
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            const SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              color: const Color(0xff212121),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(RegisterView.routeName);
                    },
                  children: [
                    const TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
