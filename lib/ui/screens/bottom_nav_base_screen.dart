import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_project/ui/screens/completed_task_screen.dart';
import 'package:task_manager_project/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager_project/ui/screens/new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {

  int _selectedScreenIndex = 0;
  final List<Widget> _screens=[
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
       unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey
        ),
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,

        currentIndex: _selectedScreenIndex,
        onTap: (int index){
         _selectedScreenIndex = index;
         if(mounted){
           setState(() {});
         }
        },

        items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'New Task'),
        BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined),label: 'Cancel'),
        BottomNavigationBarItem(icon: Icon(Icons.done_all),label: 'Completed'),
      ],
      ),
    );
  }
}
