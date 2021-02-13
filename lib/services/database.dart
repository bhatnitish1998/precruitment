import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  getUserByUid(String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: userName)
        .snapshots();
  }

  Future<void> updateUser(String userId, userMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userMap)
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  uploadOffer(offerMap) {
    FirebaseFirestore.instance
        .collection("offers")
        .add(offerMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getOffers(int branch) async {
    return await FirebaseFirestore.instance
        .collection("offers")
        .where('branches', arrayContains: branch)
        .snapshots();
  }

  addUserToOffer(String offerId, String userName) {
    FirebaseFirestore.instance.collection("offers").doc(offerId).update({
      "applied": FieldValue.arrayUnion([userName])
    });
  }
}
