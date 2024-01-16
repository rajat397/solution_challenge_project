import 'package:flutter/material.dart';
import 'package:solution_challenge_project/mybot.dart';
import 'package:solution_challenge_project/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC7jnr7VxuVBBhWd3DZGtOaMUcLZp_3pc4',
          appId: '1:396149230127:android:6a3b878b629bdc51b194da',
          messagingSenderId: '396149230127',
          projectId: 'solutionchallengeproject2024'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
