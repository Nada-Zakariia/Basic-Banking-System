import 'package:bank_app/history/history.dart';
import 'package:bank_app/view_customers.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final send;
  final int currentIndex;

  const BottomNavigator({super.key, required this.currentIndex, this.send});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int current = 0;
  List screens = [];
  @override
  void initState() {
    current = widget.currentIndex;
    screens = [const ViewCustomers(), const History()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: current,
          selectedItemColor: const Color.fromARGB(255, 88, 47, 100),
          iconSize: 28,
          type: BottomNavigationBarType.shifting,
          onTap: (index) => setState(() => current = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
              backgroundColor: Color.fromARGB(255, 222, 198, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
              backgroundColor: Color.fromARGB(255, 222, 198, 242),
            )
          ]),
      body: screens[current],
    );
  }
}
