import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Simple Firebase Test - Run this to check if Firebase is working
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Try to initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
  debugPrint('✅ SUCCESS! Firebase is initialized and working!');
  debugPrint('Firebase App Name: ${Firebase.app().name}');
  debugPrint('Firebase Project ID: ${Firebase.app().options.projectId}');
    
  } catch (e) {
    debugPrint('❌ FAILED! Firebase initialization error: $e');
  }
  
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Firebase is Working!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Check the console for details',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
