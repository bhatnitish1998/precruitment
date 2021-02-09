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
        print("Applied!!!!!!!");
        // print(widget.id);
        // print(Constants.myName);
        databaseMethods.addUserToOffer(widget.id, Constants.myName);
        return true;
      } else {
        print("INELLIGIBLE");
        return false;
      }
    }
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.company),
    //   ),
    //   body: ListView(
    //     children: [
    //       Text("Role: ${widget.role}"),
    //       Text("Test: ${widget.testDate}"),
    //       Row(
    //         children: [
    //           Text("CGPA: ${widget.cgpa}"),
    //           Text("10th: ${widget.tenth}"),
    //           Text("12th: ${widget.twelfth}"),
    //         ],
    //       ),
    //       Text(widget.deadline),
    //       Text(widget.description),
    //       Text("Salary ${widget.salary}"),
    //       SizedBox(
    //         height: 8,
    //       ),
    //       RaisedButton(
    //         onPressed: _isButtonDisabled
    //             ? () {
    //                 applyMe();
    //               }
    //             : null,
    //         child: Text("Apply"),
    //       )
    //     ],
    //   ),
    // );

    // final topContentText = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     SizedBox(height: 100.0),
    // Icon(
    //   Icons.directions_car,
    //   color: Colors.white,
    //   size: 40.0,
    // ),

    //     SizedBox(height: 10.0),
    //     Text(
    //       "${widget.role}",
    //       style: TextStyle(color: Colors.white, fontSize: 35.0),
    //     ),
    //     Container(
    //       width: 90.0,
    //       child: new Divider(color: Colors.green),
    //     ),
    //     SizedBox(height: 30.0),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         // Expanded(flex: 1, child: levelIndicator),
    //         Expanded(
    //             flex: 6,
    //             child: Padding(
    //                 padding: EdgeInsets.only(left: 10.0),
    //                 child: Text(
    //                   "${widget.testDate}",
    //                   style: TextStyle(color: Colors.white),
    //                 ))),
    //         // Expanded(flex: 1, child: coursePrice)
    //       ],
    //     ),
    //   ],
    // );

    // final topContent = Stack(
    //   children: <Widget>[
    //     Container(
    //         padding: EdgeInsets.only(left: 10.0),
    //         // height: MediaQuery.of(context).size.height * 0.5,
    //         decoration: new BoxDecoration(
    //           image: new DecorationImage(
    //             image: new AssetImage("assets/images/google.png"),
    //             fit: BoxFit.cover,
    //           ),
    //         )),
    //     Container(
    //       height: MediaQuery.of(context).size.height * 0.5,
    //       padding: EdgeInsets.all(40.0),
    //       width: MediaQuery.of(context).size.width,
    //       decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
    //       child: Center(
    //         child: topContentText,
    //       ),
    //     ),
    // Positioned(
    //   left: 8.0,
    //   top: 60.0,
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.pop(context);
    //     },
    //     child: Icon(Icons.arrow_back, color: Colors.white),
    //   ),
    // )
    // ],
    // );

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
                        final snackbar =
                            SnackBar(content: Text("Applied Successfully!"));
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
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("APPLY", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final excelButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Builder(
        builder: (context) => RaisedButton(
          onPressed: () async {
            await createExcel("Generic Co.", widget.role);
            final snackbar = SnackBar(content: Text("Excel Sheet Downloaded "));
            Scaffold.of(context).showSnackBar(snackbar);
          },
          color: Colors.blue,
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
          // RaisedButton(
          //   onPressed: () {
          //     createExcel("Generic Co.", widget.role);
          //   },
          //   child: Text("Generate Excel Sheet"),
          // )
        ],
      ),
    );

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          // Allows the user to reveal the app bar if they begin scrolling back
          // up the list of items.
          floating: true,
          // Display a placeholder widget to visualize the shrinking size.
          flexibleSpace: FlexibleSpaceBar(
            title: Text("${widget.role}"),
          ),
          pinned: true,
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 300,
        ),
        SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            (context, index) {
              return bottomContent;
            },
            childCount: 1,
          ),
        )
      ],
    )
        // body: Column(
        //   children: [topContent, bottomContent],
        // ),
        );
  }
}
