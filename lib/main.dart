import 'package:flutter/material.dart';
// import 'package:precruitment/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:precruitment/helper/authenticate.dart';
// import 'package:precruitment/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precruitment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authenticate(),
    );
  }
}
