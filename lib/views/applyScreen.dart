import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/services/database.dart';

class ApplyScreen extends StatefulWidget {
  final String company;
  final String role;
  final String testDate;
  final double cgpa;
  final double tenth;
  final double twelfth;
  final String deadline;
  final String description;
  final String salary;

  ApplyScreen({
    this.company,
    this.role,
    this.testDate,
    this.cgpa,
    this.tenth,
    this.twelfth,
    this.deadline,
    this.description,
    this.salary,
  });

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  bool _isButtonDisabled;
  bool _inelligible;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    if (widget.deadline != DateTime.now().toString()) {
      _isButtonDisabled = true;
    } else {
      _isButtonDisabled = false;
    }
    _inelligible = false;
    super.initState();
  }

  applyMe() async {
    print("Applying...");
    QuerySnapshot userSnapshot =
        await databaseMethods.getUserByUsername(Constants.myName);
    if (userSnapshot.docs[0].data()["cgpa"] < widget.cgpa) {
      print("CGPA LESS");
      _inelligible = true;
    }
    if (userSnapshot.docs[0].data()["tenth"] < widget.tenth) {
      print("10th LESS");
      _inelligible = true;
    }
    if (userSnapshot.docs[0].data()["twelfth"] < widget.twelfth) {
      print("12th LESS");
      _inelligible = true;
    }
    if (!_inelligible) {
      print("Applied!!!!!!!");
    } else {
      print("Inelligible!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company),
      ),
      body: ListView(
        children: [
          Text("Role: ${widget.role}"),
          Text("Test: ${widget.testDate}"),
          Row(
            children: [
              Text("CGPA: ${widget.cgpa}"),
              Text("10th: ${widget.tenth}"),
              Text("12th: ${widget.twelfth}"),
            ],
          ),
          Text(widget.deadline),
          Text(widget.description),
          Text("Salary ${widget.salary}"),
          SizedBox(
            height: 8,
          ),
          RaisedButton(
            onPressed: _isButtonDisabled
                ? () {
                    applyMe();
                  }
                : null,
            child: Text("Apply"),
          )
        ],
      ),
    );
  }
}
