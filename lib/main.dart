import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_list/firebase_options.dart';
import 'package:task_list/screens/authentication/view/started_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartedScreen(),
    );
  }
}
 