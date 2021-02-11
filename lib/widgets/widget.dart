import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Precruitment"),
  );
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  // fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
