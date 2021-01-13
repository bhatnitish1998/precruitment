import 'package:flutter/material.dart';
import 'package:precruitment/views/chatRoomsScreen.dart';
import 'package:precruitment/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Text('offer'),
    ChatRoom(),
    Text('profile')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          print(value);
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
