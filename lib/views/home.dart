import 'package:flutter/material.dart';
import 'package:precruitment/helper/authenticate.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/auth.dart';
import 'package:precruitment/views/addOffer.dart';
import 'package:precruitment/views/chatRoomsScreen.dart';
import 'package:precruitment/views/homeprofile.dart';
import 'package:precruitment/views/offers.dart';
import 'package:precruitment/views/search.dart';
import 'package:precruitment/views/alumini_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Offers(),
    ChatRoom(),
    HomeProfile(),
    AluminiScreen(),
  ];

  List<FloatingActionButton> _fabOptions = <FloatingActionButton>[
    FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
    FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.search),
    ),
    FloatingActionButton(
      onPressed: null,
    ),
    FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: _fabOptions.elementAt(_currentIndex),
        onTap: () {
          if (_currentIndex == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddOffer()));
          } else if (_currentIndex == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          } else if (_currentIndex == 3) {
            filePicker();
          }
        },
      ),
      appBar: AppBar(
        title: Text("Precruitment"),
        actions: [
          GestureDetector(
            onTap: () {
              AuthMethods().signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              Constants.myName = null;
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 40.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: _currentIndex == 0 ? Colors.blue : null,
                      ),
                      Text(
                        "Offers",
                        style: TextStyle(
                            color: _currentIndex == 0 ? Colors.blue : null),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  height: 40.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.forum_outlined,
                        color: _currentIndex == 1 ? Colors.blue : null,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(
                            color: _currentIndex == 1 ? Colors.blue : null),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  height: 40.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: _currentIndex == 2 ? Colors.blue : null,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: _currentIndex == 2 ? Colors.blue : null),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  height: 40.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_events_outlined,
                        color: _currentIndex == 3 ? Colors.blue : null,
                      ),
                      Text(
                        "Inspiration",
                        style: TextStyle(
                            color: _currentIndex == 3 ? Colors.blue : null),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
