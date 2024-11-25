import 'package:flutter/material.dart';
import 'package:practice_2/app.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
        enabled: true,
        builder: (context) => const TaskManagerApp()
    ),
  ); // Wrap your app
}

