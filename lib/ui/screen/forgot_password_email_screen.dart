import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_2/ui/utility/app_Colors.dart';
import 'package:practice_2/ui/widgets/screen_background.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordEmailAddress extends StatefulWidget {
  const ForgotPasswordEmailAddress({super.key});

  @override
  State<ForgotPasswordEmailAddress> createState() =>
      _ForgotPasswordEmailAddressState();
}

class _ForgotPasswordEmailAddressState
    extends State<ForgotPasswordEmailAddress> {
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
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification opt will be sent your email address',
                  style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVarifyEmailForm(),
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

  Widget _buildVarifyEmailForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: _OnTapNextButton,
          child: Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  void _OnTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordOTPScreen(),
      ),
    );
  }

  void _OnTapSignIn() {
    Navigator.pop(context);
  }
}
