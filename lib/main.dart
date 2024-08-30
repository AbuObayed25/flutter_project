import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
      //     // Flexible(
      //     //   flex: 6,
      //     //   child: Container(
      //     //     color: Colors.orange,
      //     //     width: 230,
      //     //   ),
      //     // ),
      //     // Flexible(
      //     //   flex: 9,
      //     //   child: Container(
      //     //     color: Colors.pink,
      //     //     width: 230,
      //     //   ),
      //     // ),
      //     Expanded(     //[Flexible er tight are Expanded same]
      //       child: Container(
      //         color: Colors.brown,
      //         width: 370,
      //       ),
      //     ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              width: 370,
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9, //  [generally amra ata nibo]
            child: Container(
              color: Colors.orange,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Text(constraints.maxWidth.toString());
            },
          )
        ],
      )

    );
  }
}
