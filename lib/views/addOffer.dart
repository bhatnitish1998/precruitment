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
  TextEditingController companyTextEditingController =
      new TextEditingController();
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
        "company": companyTextEditingController.text,
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
    companyTextEditingController.clear();
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
      initialDate: testDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != testDate)
      setState(() {
        testDate = picked;
      });
  }

  selectDeadlineDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: deadline,
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
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: companyTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Company Name',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: roleTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Role',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: cgpaTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Min. CGPA',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: tenthTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Min. 10th Score',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: twelfthTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Min. 12th Score',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: lpaTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Salary',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () => selectDeadlineDate(context),
                          child: Text(
                            "Select Last Date of Application",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        // Padding(padding: EdgeInsets.only(left: 20.0)),
                        Text(
                            "${deadline.day.toString()} / ${deadline.month.toString()}"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            selectTestDate(context);
                          },
                          child: Text(
                            "Select Test Date",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                            "${testDate.day.toString()} / ${testDate.month.toString()}"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      minLines: 10,
                      maxLines: 15,
                      controller: descriptionTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        filled: true,
                        fillColor: Color(0xFFDBEDFF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
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
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Add Offer",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => addOffer(),
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
