import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// We must initialize Firebase before running the app
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // The line below forces the theme to iOS (I don't know what will happen to android version)
          platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const SignIn(),
    );
  }
}