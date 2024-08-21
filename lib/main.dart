// Current SDK version: 3.22.1
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/rendering.dart';

void main(){
  runApp( DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ),);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

    //MediaQuery//

    MediaQueryData mediaQuery =MediaQuery.of(context);
    print(mediaQuery.size.height);
    print(mediaQuery.size.width);
    print(mediaQuery.size.aspectRatio);
    print(mediaQuery.size.flipped.height);
    print(mediaQuery.devicePixelRatio);

    if(mediaQuery.size.width<640){
      print("this is phone");
    }else if(mediaQuery.size.width>640&&mediaQuery.size.width<1008){
      print("this is tablet");
    }else{
      print('this is laptop');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.orange,
      ),
      // body: OrientationBuilder(
      //   builder: (context,Orientation orientation) {
      //     print(orientation);
      //     if (orientation == Orientation.portrait) {
      //       return Column(
      //         children: [
      //           Wrap(
      //             alignment: WrapAlignment.center,
      //             spacing: 14,
      //             children: [
      //               Text('hds dshllv dshdh sfnsb dhds'),
      //               Text('hds dshllv dshdhsfnsbdhds'),
      //               Text('hds dshllv dshdhsf nsbdhds'),
      //               Text('hds  dshllv dshdhsfn sbdhds'),
      //               Text('hds  dshllv dshd hsfnsbd hds'),
      //               Text('hds  dshllv dshd hsfns bdhds'),
      //               Text('hds  dshllv dsh dhsf nsb dhds'),
      //               Text('hds  dshllv dshdh sfnsb dhds'),
      //               Text('hds  dshllv ds hdh sfnsb  dhds'),
      //               Text('hds  dshllv dsh dhs      fns bdhds'),
      //               Text('hds  dshllv bdhds'),
      //             ],
      //           )
      //         ],
      //       );
      //     }else{
      //       return Center(
      //         child: Text("Too big vai"),
      //       );
      //     }
      //   }
      // ),
      body: LayoutBuilder(
        builder: (context,BoxConstraints constraints){
          if(constraints.maxWidth<640){
            return Text("this is phone");
          }else if(constraints.maxWidth>640&&constraints.maxWidth<1008){
            return Text("this is tablet");
          }else{
            return Text('this is laptop');
          }
      }
      ),
    );
  }
}
