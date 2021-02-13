import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/widgets/widget.dart';

class HomeProfile extends StatefulWidget {
  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  String email;
  String name;
  String address;
  String dob;
  String phone;
  double cgpa;
  double twelfth;
  double tenth;
  int branch = 0;
  bool loading = true;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot snap;

  @override
  initState() {
    Future.delayed(Duration.zero).then((_) async {
      QuerySnapshot temp = await databaseMethods
          .getUserByUid(FirebaseAuth.instance.currentUser.uid);
      setState(() {
        snap = temp;
        loading = false;
      });
    });
    super.initState();
  }

  Widget _buildUSN(String usn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  USN',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            usn,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildName(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Name',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmail(String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Email',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            email,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPhone(String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Phone',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBranch(String branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Branch',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            branch,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAddress(String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Address',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            address,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildcgpa(String cgpa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  CGPA',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            cgpa,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildtenth(String tenth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  10th',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            tenth,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildtwelfth(String twelfth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  12th',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            twelfth,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDOB(String dob) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  DOB',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            dob,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                // color: Color(0xFF6CA8F1),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ],
                    ),
                    CustomPaint(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      painter: HeaderCurvedContainer(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 35.0,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image:
                                  ExactAssetImage("assets/images/default.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 75),
                                _buildUSN(snap.docs[0].data()["name"]),
                                _buildName(snap.docs[0].data()["fullname"]),
                                _buildEmail(
                                    snap.docs[0].data()["personalMail"]),
                                _buildPhone(snap.docs[0].data()["phone"]),
                                _buildBranch(Constants
                                    .branches[snap.docs[0].data()["branch"]]),
                                _buildAddress(snap.docs[0].data()["address"]),
                                _buildcgpa(
                                    snap.docs[0].data()["cgpa"].toString()),
                                _buildtenth(
                                    snap.docs[0].data()["tenth"].toString()),
                                _buildtwelfth(
                                    snap.docs[0].data()["twelfth"].toString()),
                                _buildDOB(snap.docs[0].data()["DOB"]),
                              ],
                            ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 210, left: 170),
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF6CA8F1);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
