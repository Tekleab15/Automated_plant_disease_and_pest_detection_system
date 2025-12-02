import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:plant_disease_detection/Screens/home_screen.dart';
import 'package:plant_disease_detection/Screens/plantDetailsScreen.dart';
import 'package:plant_disease_detection/Screens/profile_screen.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenPage> {
  // Track the index of selected tab
  int _currentIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = [
    // First tab
    HomeScreen(),
    // Second tab
    DiseaseInfoScreen(),
    // Third tab
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      // Change the selected tab
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the selected page
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Current active tab
        currentIndex: _currentIndex,
        // Tap handler
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Detect Disease',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // Highlight selected item
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
