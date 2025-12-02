// import 'package:flutter/material.dart';
// import 'package:plant_disease_detection/Language/ChangeNotifier.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:plant_disease_detection/Database/database_helper.dart';
// import 'package:plant_disease_detection/Screens/home_screen.dart';
// import 'package:plant_disease_detection/Screens/registerScreen.dart';
// import 'package:plant_disease_detection/Screens/scratch_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _email;
//   String? _password;

//   // Dropdown value for language selection
//   String _selectedLanguage = 'English';

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       var user = await DatabaseHelper().getUser(_email!, _password!);
//       if (user != null) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('userEmail', _email!);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const MainScreenPage(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Invalid email or password')),
//         );
//       }
//     }
//   }

//   // Language change function
//   void _changeLanguage(String language) {
//     setState(() {
//       _selectedLanguage = language;
//       // Add localization logic here for actual language changes
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final languageNotifier = Provider.of<LanguageNotifier>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Login Page',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           DropdownButton<String>(
//             value: languageNotifier.currentLanguage,
//             icon: const Icon(Icons.language),
//             onChanged: (String? newLanguage) {
//               if (newLanguage != null) {
//                 languageNotifier.changeLanguage(newLanguage);
//               }
//             },
//             items: const [
//               DropdownMenuItem(value: 'eng', child: Text('English')),
//               DropdownMenuItem(value: 'tig', child: Text('Tigrigna')),
//               DropdownMenuItem(value: 'amh', child: Text('Amharic')),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: languageNotifier.translate('Email'),
//                   border: OutlineInputBorder(),
//                   prefixIcon: const Icon(Icons.email),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _email = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: languageNotifier.translate('Password'),
//                   border: OutlineInputBorder(),
//                   prefixIcon: const Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   } else if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _password = value,
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _login,
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   backgroundColor: const Color(0xFF0AC898),
//                   textStyle: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 child: Text(languageNotifier.translate('Login')),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const RegisterScreen(),
//                         ),
//                       );
//                     },
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 15),
//                     ),
//                     child: Text(languageNotifier.translate('Register'),
//                         style: TextStyle(fontSize: 14)),
//                   ),
//                   const SizedBox(width: 20),
//                   TextButton(
//                     onPressed: () {},
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 15),
//                     ),
//                     child: Text(
//                       languageNotifier.translate('Forgot'),
//                       style: TextStyle(
//                         color: Color.fromARGB(132, 28, 91, 143),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plant_disease_detection/Language/ChangeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_disease_detection/Database/database_helper.dart';
import 'package:plant_disease_detection/Screens/home_screen.dart';
import 'package:plant_disease_detection/Screens/registerScreen.dart';
import 'package:plant_disease_detection/Screens/scratch_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var user = await DatabaseHelper().getUser(_email!, _password!);
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', _email!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreenPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    // Debugging: Print current language and items
    print("Current Language: ${languageNotifier.currentLanguage}");

    // Define the items in the dropdown
    const List<DropdownMenuItem<String>> languageItems = [
      DropdownMenuItem(value: 'eng', child: Text('English')),
      DropdownMenuItem(value: 'tig', child: Text('Tigrigna')),
      DropdownMenuItem(value: 'amh', child: Text('Amharic')),
    ];

    // Ensure that the value exists in the items
    final isValidValue = languageItems
        .any((item) => item.value == languageNotifier.currentLanguage);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageNotifier.translate('Login Page'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: isValidValue
                ? languageNotifier.currentLanguage
                : null, // Ensure valid value
            icon: const Icon(Icons.language),
            onChanged: (String? newLanguage) {
              if (newLanguage != null) {
                print("Language changed to: $newLanguage"); // Debug log
                languageNotifier.changeLanguage(newLanguage);
              }
            },
            items: languageItems,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: languageNotifier.translate('Email'),
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: languageNotifier.translate('Password'),
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: const Color(0xFF0AC898),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(languageNotifier.translate('Login')),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: Text(languageNotifier.translate('Register'),
                        style: TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: Text(
                      languageNotifier.translate('Forgot'),
                      style: TextStyle(
                        color: Color.fromARGB(132, 28, 91, 143),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
