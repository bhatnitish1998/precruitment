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

Map<int, Color> primary = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor customPrimary = MaterialColor(0xFF735290, primary);

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
    super.initState();
    // });
  }

  Future<Null> getLoggedInState() async {
    HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          userIsLoggedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Precruitment',
      theme: ThemeData(
        primarySwatch: customPrimary,
        // 0xFFC4A69D
        // 0xFFDAA89B
        // 0xFFC76D7E
        accentColor: Color(0xFFC76D7E),
        bottomAppBarColor: Color(0xFFEEEEEE),
      ),
      home: userIsLoggedIn ? Home() : Authenticate(),
    );
  }
}
