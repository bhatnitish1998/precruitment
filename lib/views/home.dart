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

  @override
  void initState() {
    HelperFunctions.getUserNameSharedPreference().then((value) {
      Constants.myName = value;
    });
    HelperFunctions.getUserRoleSharedPreference().then((value) {
      Constants.role = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FloatingActionButton> _fabOptions = <FloatingActionButton>[
      FloatingActionButton(
        onPressed: null,
        child: (Constants.role == Constants.adminRole) ? Icon(Icons.add) : null,
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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        child: _fabOptions.elementAt(_currentIndex),
        onTap: () {
          if (_currentIndex == 0 && Constants.role == Constants.adminRole) {
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
          InkWell(
            onTap: () {
              AuthMethods().signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              Constants.myName = null;
              Constants.role = null;
              HelperFunctions.saveUserRoleSharedPreference("USERROLEKEY");
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 0
                              ? Icons.article
                              : Icons.article_outlined,
                          color: _currentIndex == 0
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        Text(
                          "Offers",
                          style: TextStyle(
                            color: _currentIndex == 0
                                ? Theme.of(context).primaryColor
                                : null,
                            fontWeight:
                                _currentIndex == 0 ? FontWeight.w600 : null,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 1
                              ? Icons.forum
                              : Icons.forum_outlined,
                          color: _currentIndex == 1
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        Text(
                          "Chat",
                          style: TextStyle(
                            color: _currentIndex == 1
                                ? Theme.of(context).primaryColor
                                : null,
                            fontWeight:
                                _currentIndex == 1 ? FontWeight.w600 : null,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 2
                              ? Icons.person
                              : Icons.person_outlined,
                          color: _currentIndex == 2
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: _currentIndex == 2
                                ? Theme.of(context).primaryColor
                                : null,
                            fontWeight:
                                _currentIndex == 2 ? FontWeight.w600 : null,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 3
                              ? Icons.emoji_events
                              : Icons.emoji_events_outlined,
                          color: _currentIndex == 3
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        Text(
                          "Inspiration",
                          style: TextStyle(
                            color: _currentIndex == 3
                                ? Theme.of(context).primaryColor
                                : null,
                            fontWeight:
                                _currentIndex == 3 ? FontWeight.w600 : null,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
