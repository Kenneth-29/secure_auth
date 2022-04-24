import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secure_auth/pages/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCTbV44vzBc9mk6yOhB6gJuOv-MWg9hEds",
    appId: "1:85837233230:web:4c08ad058b8ae6910c971f",
    messagingSenderId: "85837233230",
    projectId: "auth-27535",
    authDomain: "auth-27535.firebaseapp.com",
    measurementId: "G-QLFSLHQBJ0",
    storageBucket: "auth-27535.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Authentication',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
