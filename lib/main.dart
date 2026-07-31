import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:truxperts/Auth/Splash_screen.dart';
import 'package:truxperts/firebase_options.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized');
  } catch (e) {
    print('❌ Firebase init error: $e');
  }

  try {
    // ✅ Initialize SharedPreferences
    await AppPreferences.init();
    print('✅ SharedPreferences initialized');
  } catch (e) {
    print('❌ SharedPreferences init error: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}