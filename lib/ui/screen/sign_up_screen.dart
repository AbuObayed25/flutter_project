import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:practice_2/data/services/network_caller.dart';
import 'package:practice_2/data/utils/urls.dart';
import 'package:practice_2/ui/utility/app_Colors.dart';
import 'package:practice_2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:practice_2/ui/widgets/screen_background.dart';

import '../widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name='/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _FirstNameTEController = TextEditingController();
  final TextEditingController _LastNameTEController = TextEditingController();
  final TextEditingController _MobileTEController = TextEditingController();
  final TextEditingController _PasswordTEController = TextEditingController();
  bool _inProgress = false;

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
                  'Join With Us',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                _buildSignInForm(),
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

  Widget _buildSignInForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter valid email";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _FirstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'First name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter First name";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _LastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Last name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Last name";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _MobileTEController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Mobile'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Mobile number";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _PasswordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your Password";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inProgress,
            replacement: CenteredCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _OnTapNextButton,
              child: Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  void _OnTapNextButton() {
    if (_formkey.currentState!.validate()) {
      _signup();
    }
  }

  Future<void> _signup() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _FirstNameTEController.text.trim(),
      "lastName": _LastNameTEController.text.trim(),
      "mobile": _MobileTEController.text.trim(),
      "password": _PasswordTEController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );

    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New user created');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _FirstNameTEController.clear();
    _LastNameTEController.clear();
    _MobileTEController.clear();
    _PasswordTEController.clear();
  }

  void _OnTapSignIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _FirstNameTEController.dispose();
    _LastNameTEController.dispose();
    _MobileTEController.dispose();
    _PasswordTEController.dispose();
    super.dispose();
  }
}
