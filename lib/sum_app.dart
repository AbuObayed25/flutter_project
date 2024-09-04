import 'package:flutter/material.dart';
import 'package:flutter_project/home_screen.dart';

class SumApp extends StatelessWidget {
  const SumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            letterSpacing: 1.2,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        )

      ),
    );
  }
}
