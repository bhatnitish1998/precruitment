import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/widgets/widget.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formkey = GlobalKey<FormState>();
  String message = "";
  TextEditingController roleTextEditingController = new TextEditingController();
  TextEditingController cgpaTextEditingController = new TextEditingController();
  TextEditingController tenthTextEditingController =
      new TextEditingController();
  TextEditingController twelfthTextEditingController =
      new TextEditingController();
  TextEditingController lpaTextEditingController = new TextEditingController();
  TextEditingController descriptionTextEditingController =
      new TextEditingController();
  List<bool> branches = [false, false, false, false, false, false, false];
  DateTime testDate = DateTime.now();
  DateTime deadline = DateTime.now();

  addOffer() {
    if (formkey.currentState.validate()) {
      List<int> b = [];
      for (int i = 0; i < branches.length; i++) {
        if (branches[i] == true) {
          b.add(i);
        }
      }
      print(b);
      Map<String, dynamic> offerMap = {
        "company": "Generic Co.", //TODO
        "role": roleTextEditingController.text,
        "minCGPA": double.parse(cgpaTextEditingController.text),
        "minTenth": double.parse(tenthTextEditingController.text),
        "minTwelfth": double.parse(twelfthTextEditingController.text),
        "description": descriptionTextEditingController.text,
        "deadline": deadline,
        "salary": double.parse(lpaTextEditingController.text),
        "testDate": testDate,
        "branches": b
      };

      databaseMethods.uploadOffer(offerMap);
      setState(() {
        message = "Offer Added Succesfully!";
      });
    }
    roleTextEditingController.clear();
    cgpaTextEditingController.clear();
    tenthTextEditingController.clear();
    twelfthTextEditingController.clear();
    descriptionTextEditingController.clear();
    lpaTextEditingController.clear();

    setState(() {
      for (int i = 0; i < branches.length; i++) {
        branches[i] = false;
      }
    });
  }

  selectTestDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: testDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != testDate)
      setState(() {
        testDate = picked;
      });
  }

  selectDeadlineDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: deadline, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != deadline)
      setState(() {
        deadline = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: roleTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Role",
                      ),
                    ),
                    TextFormField(
                      controller: cgpaTextEditingController,
                      decoration: InputDecoration(
                        hintText: "CGPA",
                      ),
                    ),
                    TextFormField(
                      controller: tenthTextEditingController,
                      decoration: InputDecoration(
                        hintText: "10th",
                      ),
                    ),
                    TextFormField(
                      controller: twelfthTextEditingController,
                      decoration: InputDecoration(
                        hintText: "12th",
                      ),
                    ),

                    TextFormField(
                      controller: lpaTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Salary",
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: () => selectDeadlineDate(context),
                          child: Text("Select Last Date of Application"),
                        ),
                        // Padding(padding: EdgeInsets.only(left: 20.0)),
                        Text(
                            "${deadline.day.toString()} / ${deadline.month.toString()}"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: () {
                            selectTestDate(context);
                          },
                          child: Text("Select Test Date"),
                        ),
                        Text(
                            "${testDate.day.toString()} / ${testDate.month.toString()}"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    // TextFormField(
                    //   controller: testDateTextEditingController,
                    //   decoration: InputDecoration(
                    //     hintText: "TestDate",
                    //   ),
                    // ),
                    TextFormField(
                      controller: descriptionTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Branches",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: branches[0],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[0] = value;
                                  });
                                }),
                            Text(Constants.branches[0])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[1],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[1] = value;
                                  });
                                }),
                            Text(Constants.branches[1])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[2],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[2] = value;
                                  });
                                }),
                            Text(Constants.branches[2])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[3],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[3] = value;
                                  });
                                }),
                            Text(Constants.branches[3])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[4],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[4] = value;
                                  });
                                }),
                            Text(Constants.branches[4])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[5],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[5] = value;
                                  });
                                }),
                            Text(Constants.branches[5])
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: branches[6],
                                onChanged: (bool value) {
                                  setState(() {
                                    branches[6] = value;
                                  });
                                }),
                            Text(Constants.branches[6])
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(message),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          addOffer();
                        },
                        child: RaisedButton(
                          child: Text(
                            "Add Offer",
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
