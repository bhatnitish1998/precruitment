import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/services/generate_excel.dart';

class ApplyScreen extends StatefulWidget {
  final String id;
  final String company;
  final String role;
  final DateTime testDate;
  final double cgpa;
  final double tenth;
  final double twelfth;
  final DateTime deadline;
  final String description;
  final String salary;

  ApplyScreen({
    this.id,
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
    if (DateTime.now().isAfter(widget.deadline) ||
        DateTime.now().isAfter(widget.testDate)) {
      _isButtonDisabled = true;
    } else {
      _isButtonDisabled = false;
    }
    _inelligible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        databaseMethods.addUserToOffer(widget.id, Constants.myName);
        return true;
      } else {
        print("INELLIGIBLE");
        return false;
      }
    }

    final bottomContentText = Column(
      children: [
        Text(
          "Company: ${widget.company}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "Test Date: ${widget.testDate.day} / ${widget.testDate.month}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "CGPA: ${widget.cgpa}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "10th: ${widget.tenth}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "12th: ${widget.twelfth}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "Deadline: ${widget.deadline.day} / ${widget.deadline.month}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "Description: ${widget.description}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "Salary: ${widget.salary}",
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );

    final readButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Builder(
        builder: (context) => RaisedButton(
          onPressed: !_isButtonDisabled
              ? () {
                  applyMe().then(
                    (value) {
                      if (value) {
                        final snackbar = SnackBar(
                          content: Text("Applied Successfully!"),
                          backgroundColor: Theme.of(context).primaryColor,
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      } else {
                        final snackbar = SnackBar(
                            content: Text("Sorry, You are inelligible..."));
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                  );
                }
              : null,
          color: Theme.of(context).accentColor,
          child: Text("APPLY", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final excelButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Builder(
        builder: (context) => RaisedButton(
          onPressed: () async {
            await createExcel(widget.company, widget.role);
            final snackbar = SnackBar(content: Text("Excel Sheet Downloaded "));
            Scaffold.of(context).showSnackBar(snackbar);
          },
          color: Theme.of(context).accentColor,
          child: Text("Generate Excel Sheet",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          bottomContentText,
          readButton,
          excelButton,
        ],
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${widget.role}"),
            ),
            pinned: true,
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return bottomContent;
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
