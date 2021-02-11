import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/views/conversation_screen.dart';
import 'package:precruitment/widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot.docs[index].data()["name"],
                userEmail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  initiateSearch() {
    databaseMethods.getUserByUsername(searchEditingController.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatroomAndStartConversation({String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print("You cannot msg yourself");
    }
  }

  Widget searchTile({String userName, String userEmail}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName),
                Text(userEmail),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                createChatroomAndStartConversation(userName: userName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(13),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text("Message"),
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      decoration: InputDecoration(
                          hintText: "Search Username ...",
                          hintStyle: TextStyle(
                            // color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        initiateSearch();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.search))),
                ],
              ),
            ),
            Container(
              // margin: new EdgeInsets.symmetric(vertical: 2.0),
              height: 2.0,
              width: MediaQuery.of(context).size.width,
              color: new Color(0xff00c6ff),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
