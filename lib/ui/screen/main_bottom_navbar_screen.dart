import 'package:flutter/material.dart';
import 'package:practice_2/ui/screen/cancel_task_screen.dart';
import 'package:practice_2/ui/screen/completed_task_screen.dart';
import 'package:practice_2/ui/screen/new_task_screen.dart';
import 'package:practice_2/ui/screen/progress_task_screen.dart';
import 'package:practice_2/ui/utility/app_Colors.dart';

import '../widgets/tm_app_bar.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens=const[
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index){
          _selectedIndex =index;
          setState(() { });
        },
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.new_label),
              label: 'New'),
          NavigationDestination(
              icon: Icon(Icons.check_box),
              label: 'Completed'),
          NavigationDestination(
              icon: Icon(Icons.close),
              label: 'Cancelled'),
          NavigationDestination(
              icon: Icon(Icons.pause_circle_filled),
              label: 'Progress'),
        ],
      ),
    );
  }
}
