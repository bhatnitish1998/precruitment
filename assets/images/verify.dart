import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/views/profile.dart';
import 'package:precruitment/widgets/widget.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // signUpPage() {
  //     Navigator.of(context)
  //     .pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        // color: Colors.amber,
        padding: EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "YOU'RE ONE STEP AWAY!",
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Verify your Email ID", style: TextStyle(fontSize: 30)),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Text("A link has been sent to "),
              Text("${user.email}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ]),
          ),
          // SizedBox(
          //   height: 50,
          // ),
          // RaisedButton(
          //   onPressed: null,
          //   child: Text("Resend Email"),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Entered a wrong email?  "),
          //     GestureDetector(
          //       onTap: () {
          //         null;
          //       },
          //       child: Container(
          //         padding: EdgeInsets.symmetric(vertical: 8),
          //         child: Text(
          //           "Click here.",
          //           style: TextStyle(decoration: TextDecoration.underline),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 20),
        ]),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
    }
  }
}
