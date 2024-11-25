import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:practice_2/ui/screen/reset_password_screen.dart';
import 'package:practice_2/ui/screen/sign_in_screen.dart';
import 'package:practice_2/ui/utility/app_Colors.dart';
import 'package:practice_2/ui/widgets/screen_background.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  const ForgotPasswordOTPScreen({super.key});

  @override
  State<ForgotPasswordOTPScreen> createState() =>
      _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen> {
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
                  'Pin Varification',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification opt has been sent your email address',
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
        PinCodeTextField(
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: _OnTapNextButton,
          child: Text("Varify"),
        ),
      ],
    );
  }

  void _OnTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }

  void _OnTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
          (_) => false,
    );
  }
}
