import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_2/ui/screen/sign_in_screen.dart';
import 'package:practice_2/ui/utility/app_Colors.dart';
import 'package:practice_2/ui/widgets/screen_background.dart';

import 'forgot_password_otp_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =
        Theme.of(context).textTheme; // short korer jonno korlam

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum length password 8 character with Latter and number combination',
                  style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildResetPasswordForm(),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      _buildHaveAccountSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _OnTapForgotPasswordButton() {
    //ToDo : Implement for forgot password
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        text: "Have account? ",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
        ),
        children: [
          TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = _OnTapSignIn),
        ],
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(hintText: 'Confirm Password'),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: _OnTapNextButton,
          child: Text("Confirm"),
        ),
      ],
    );
  }

  void _OnTapNextButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
            (_) => false);
  }

  void _OnTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
            (_) => false);
  }

}
