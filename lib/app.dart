import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_2/controller_binder.dart';
import 'package:practice_2/ui/screen/add_new_task_screen.dart';
import 'package:practice_2/ui/screen/cancel_task_screen.dart';
import 'package:practice_2/ui/screen/completed_task_screen.dart';
import 'package:practice_2/ui/screen/forgot_password_email_screen.dart';
import 'package:practice_2/ui/screen/forgot_password_otp_screen.dart';
import 'package:practice_2/ui/screen/main_bottom_navbar_screen.dart';
import 'package:practice_2/ui/screen/new_task_screen.dart';
import 'package:practice_2/ui/screen/profile_screen.dart';
import 'package:practice_2/ui/screen/progress_task_screen.dart';
import 'package:practice_2/ui/screen/reset_password_screen.dart';
import 'package:practice_2/ui/screen/sign_in_screen.dart';
import 'package:practice_2/ui/screen/sign_up_screen.dart';
import 'package:practice_2/ui/screen/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'ui/utility/app_Colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      // routes: {
      //   SplashScreen.name: (context) => const SplashScreen(),
      //   MainBottomNavbarScreen.name: (context) =>
      //       const MainBottomNavbarScreen(),
      // },
    onGenerateRoute: (RouteSettings settings) {
      late Widget widget;
      if (settings.name == SplashScreen.name) {
        widget = const SplashScreen();
      } else if (settings.name == MainBottomNavbarScreen.name) {
        widget = const MainBottomNavbarScreen();
      } else if (settings.name == NewTaskScreen.name) {
        widget = const NewTaskScreen();
      } else if (settings.name == AddNewTaskScreen.name) {
        widget = const AddNewTaskScreen();
      } else if (settings.name == CancelTaskScreen.name) {
        widget = const CancelTaskScreen();
      } else if (settings.name == CompletedTaskScreen.name) {
        widget = const CompletedTaskScreen();
      }else if (settings.name == ForgotPasswordOTPScreen.name) {
        widget = const ForgotPasswordOTPScreen();
      }else if (settings.name == ForgotPasswordEmailAddress.name) {
        widget = const ForgotPasswordEmailAddress();
      }else if (settings.name == ProfileScreen.name) {
        widget = const ProfileScreen();
      } else if (settings.name == SignInScreen.name) {
        widget = const SignInScreen();
      }else if (settings.name == SignUpScreen.name) {
        widget = const SignUpScreen();
      }else if (settings.name == ResetPasswordScreen.name) {
        widget = const ResetPasswordScreen();
      } else if (settings.name == ProgressTaskScreen.name) {
        widget = const ProgressTaskScreen();
      }
      // else if (settings.name == ProductListScreen.name) {
      //   String name = settings.arguments as String;
      //   widget = ProductListScreen(categoryName: name,);
      // }
      return MaterialPageRoute(
        builder: (ctx) {
          return widget;
        },
      );
    }
    );
  }
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    border: _InputBorder(),
    enabledBorder: _InputBorder(),
    errorBorder: _InputBorder(),
    focusedBorder: _InputBorder(),
  );
}

OutlineInputBorder _InputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8));
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );
}
