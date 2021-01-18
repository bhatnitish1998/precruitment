import 'package:flutter/material.dart';
import 'package:precruitment/helper/authenticate.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/auth.dart';
import 'package:precruitment/views/chatRoomsScreen.dart';
import 'package:precruitment/views/offers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Offers(),
    ChatRoom(),
    Text('profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precruitment"),
        actions: [
          GestureDetector(
            onTap: () {
              AuthMethods().signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        // selectedFontSize: 15,
        // unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            label: "Offers",
            icon: Icon(Icons.notes),
          ),
          BottomNavigationBarItem(label: "Chat", icon: Icon(Icons.chat)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.face)),
        ],
      ),
    );
  }
}
