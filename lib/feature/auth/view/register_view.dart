import 'package:cartizy_app_nti/core/widgets/text_form_field_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const String routeName = "RegisterScreen";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
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
              controller: _emailController,
              onValidate: Validator.validateEmail,
              hint: "Enter your email",
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
              controller: _passwordController,
              onValidate: Validator.validatePassword,
              hint: 'Enter your password',
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            const SizedBox(height: 30),
            const Text(
              "Confirm Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            TextFormFieldHelper(
              controller: _confirmPasswordController,
              onValidate: (value) => Validator.validateConfirmPassword(
                value,
                _passwordController.text,
              ),
              hint: "Enter your confirm password",
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.done,
            ),
            const SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              color: const Color(0xff212121),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Sign up",
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
                  text: "Already have an account? ",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    },
                  children: [
                    const TextSpan(
                      text: "Login",
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
