import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/auth.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/views/verify.dart';
import 'package:precruitment/widgets/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formkey = GlobalKey<FormState>();
  final loadkey = GlobalKey<State>();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      userNameTextEditingController.text =
          userNameTextEditingController.text.trim().toUpperCase();
      emailTextEditingController.text =
          emailTextEditingController.text.trim().toLowerCase();

      Map<String, String> userMapInfo = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text,
        "role": Constants.studentRole
      };

      HelperFunctions.saveUserNameSharedPreference(
          userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      Constants.myName = userNameTextEditingController.text;

      setState(() {
        _isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        userMapInfo["uid"] = value;
        databaseMethods.uploadUserInfo(userMapInfo);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Verify(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.trim().isEmpty ||
                                        val.trim().length < 4
                                    ? "Bad Username"
                                    : null;
                              },
                              controller: userNameTextEditingController,
                              decoration: InputDecoration(
                                hintText: "username",
                              ),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^01(fe|FE)\d\d(b|B)[a-zA-Z][a-zA-Z]\d\d\d@(kletech.ac.in|KLETECH.AC.IN)$")
                                        .hasMatch(val.trim())
                                    ? null
                                    : "Please enter a valid KLE Tech Email ID";
                              },
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length < 6
                                    ? "Invalid Password"
                                    : null;
                              },
                              controller: passwordTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //     child: Text("Forgot Password?"),
                      //   ),
                      // ),//TODO
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: RaisedButton(
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: null,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Login.",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
