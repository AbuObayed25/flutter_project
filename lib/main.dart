import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.orange
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          )
      ),
      themeMode: ThemeMode.system,
      home:  Home(),
    );
  }
}

class Home extends StatefulWidget {
  //const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int Counter=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Home'),
      ),
      body: Center(
        child:Text("$Counter",style: TextStyle(fontSize: 30),),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              Counter++;
              setState(()    //re build er jonno setState() use kora lagbe
              {
              });
            },
            child: const Icon(Icons.add),
          ),
         const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: (){
              Counter--;
              setState(()    //re build er jonno setState() use kora lagbe
              {
              }
              );
            },child:const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
