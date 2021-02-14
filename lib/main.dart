import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:precruitment/helper/authenticate.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:precruitment/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: false);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
    getLoggedInState();
    // });
    super.initState();
  }

  getLoggedInState() {
    HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        if (value != null) {
          userIsLoggedIn = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precruitment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn ? Home() : Authenticate(),
    );
  }
}
