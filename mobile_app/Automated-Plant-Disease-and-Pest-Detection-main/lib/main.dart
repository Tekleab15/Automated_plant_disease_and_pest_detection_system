import 'package:flutter/material.dart';
import 'package:plant_disease_detection/Language/ChangeNotifier.dart';
import 'package:plant_disease_detection/Screens/login_screen.dart';
import 'package:plant_disease_detection/Screens/scratch_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'Language/';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageNotifier(),
    child: IntialPageToMaterialApp(),
  ));
}

class IntialPageToMaterialApp extends StatelessWidget {
  const IntialPageToMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_Image.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontFamily: "Roboto-Bold",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                )
              },
              icon: Icon(Icons.arrow_forward),
              label: const Text(" Lets Go"),
            ),
          ]),
        ),
      ),
    );
  }
}
