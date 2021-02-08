import 'package:flutter/material.dart';
import 'package:precruitment/models/user.dart';
import 'package:precruitment/views/home.dart';
import 'package:precruitment/widgets/widget.dart';
import 'package:flutter/services.dart';
import 'package:precruitment/utilities/constants.dart';
import 'package:precruitment/services/database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email;
  String name;
  String address;
  String dob;
  String phone;
  double cgpa;
  double twelfth;
  double tenth;
// enum branch;
// enum gender;
  bool placedStatus;
  String course;

  // Map<String, String> userMapInfo = {
  //       "name": userNameTextEditingController.text,
  //       "email": emailTextEditingController.text
  //     };

// List<Offer._id> appliedOffers;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  User user = User();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _userAddressController = TextEditingController();
  TextEditingController _userCGPAController = TextEditingController();
  TextEditingController _userTenthController = TextEditingController();
  TextEditingController _userTwelfthController = TextEditingController();
  TextEditingController _userDOBController = TextEditingController();
// TextEditingController _userNameController = TextEditingController();
// TextEditingController _userNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Name',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your full name',
              hintStyle: kHintTextStyle,
            ),
            controller: _userNameController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Name is required";
              }
              return null;
            },
            onSaved: (String value) {
              name = value;
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Email',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            controller: _userEmailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Email is required";
              }
              if (!RegExp(
                      r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                  .hasMatch(value)) {
                return "Invalid Email";
              }
              return null;
            },
            onSaved: (String value) {
              email = value;
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Phone Number',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 65.0,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your mobile number',
              hintStyle: kHintTextStyle,
            ),
            maxLength: 10,
            controller: _userPhoneController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Mobile number is required";
              }
              if (!RegExp(r"^[6789]\d{9}$").hasMatch(value)) {
                return "Invalid Number";
              }
              return null;
            },
            onSaved: (String value) {
              phone = value;
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  Address',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 150.0,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText:
                  'Enter your residential address :\nAddress Line 1,\nAddress Line 2,\nCity, State,\nPincode.',
              hintStyle: kHintTextStyle,
            ),
            controller: _userAddressController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Address is required";
              }
              return null;
            },
            onSaved: (String value) {
              address = value;
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildcgpa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  CGPA',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter Your CGPA',
              hintStyle: kHintTextStyle,
            ),
            controller: _userCGPAController,
            validator: (String value) {
              if (value.isEmpty) {
                return "CGPA is required";
              }
              if (double.parse(value) > 10 || double.parse(value) < 0) {
                return "Invalid CGPA";
              }
              return null;
            },
            onSaved: (String value) {
              cgpa = double.parse(value);
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildtenth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  10\u1d57\u02b0 Percentage',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter Your SSLC%',
              hintStyle: kHintTextStyle,
            ),
            controller: _userTenthController,
            validator: (String value) {
              if (value.isEmpty) {
                return "SSLC percentage is required";
              }
              if (double.parse(value) > 100 || double.parse(value) < 0) {
                return "Invalid Percentage";
              }
              return null;
            },
            onSaved: (String value) {
              tenth = double.parse(value);
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildtwelfth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  12\u1d57\u02b0 Percentage',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your PUC%',
              hintStyle: kHintTextStyle,
            ),
            controller: _userTwelfthController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Twelfth percentage is required";
              }
              if (double.parse(value) > 100 || double.parse(value) < 0) {
                return "Invalid Percentage";
              }
              return null;
            },
            onSaved: (String value) {
              twelfth = double.parse(value);
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDOB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '  DOB',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'DD-MM-YYYY',
              hintStyle: kHintTextStyle,
            ),
            controller: _userDOBController,
            validator: (String value) {
              if (value.isEmpty) {
                return "DOB is required";
              }
              if (!RegExp(
                      r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$")
                  .hasMatch(value)) {
                return "Invalid DOB";
              }
              return null;
            },
            onSaved: (String value) {
              dob = value;
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  profileComplete() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    Map<String, dynamic> userMapInfo = {
      'email': _userEmailController.text,
      'name': _userNameController.text,
      'address': _userAddressController.text,
      'phone': _userPhoneController.text,
      'CGPA': _userCGPAController.text,
      'twelfth': _userTwelfthController.text,
      'tenth': _userTenthController.text,
      'DOB': _userDOBController.text,
      // 'placedStatus': _userEmailController.text,
      // 'course': _userEmailController.text,
    };

    databaseMethods.uploadUserInfo(userMapInfo);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: profileComplete,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Color(0xFF527DAA),
        child: Text(
          'Save Details',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: SingleChildScrollView(
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
                        image: ExactAssetImage("assets/images/default.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(24),
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 75),
                              _buildName(),
                              _buildEmail(),
                              _buildPhone(),
                              _buildAddress(),
                              _buildcgpa(),
                              _buildtenth(),
                              _buildtwelfth(),
                              _buildDOB(),
                              _buildLoginBtn(),
                              // RaisedButton(
                              //     child: Text("Save Details"),
                              //     onPressed: profileComplete)
                            ],
                          )))
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
        )));
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
