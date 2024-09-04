import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/sum_app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const SumApp()
    ),
  ); // Wrap your app
}

