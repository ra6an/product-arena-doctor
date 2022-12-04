import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/custom_button.dart';
import 'package:flutter_application/common/widgets/custom_textfield.dart';
import 'package:flutter_application/features/auth/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _signInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment,
              children: [
                ClipRect(
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                    // height: 40,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'E-mail',
                  // valid: validateController(_emailController) ? true : false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  suffix: true,
                  // valid: validateController(_passwordController) ? true : false,
                ),
                const SizedBox(height: 20),
                // DIO ZA ERROR HANDLE!!! DOVRSITI
                // Container(
                //   child: const Text(
                //     'Greska',
                //     style: TextStyle(
                //       fontSize: 16,
                //       color: GlobalVariables.errorColor,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Log In',
                  onTap: () {
                    if (_signInFormKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
