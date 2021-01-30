import 'package:flutter/material.dart';
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
  TextEditingController deadlineTextEditingController =
      new TextEditingController();
  TextEditingController lpaTextEditingController = new TextEditingController();
  TextEditingController testDateTextEditingController =
      new TextEditingController();
  TextEditingController descriptionTextEditingController =
      new TextEditingController();

  addOffer() {
    if (formkey.currentState.validate()) {
      Map<String, dynamic> offerMap = {
        "company": "Generic Co.", //TODO
        "role": roleTextEditingController.text,
        "minCGPA": double.parse(cgpaTextEditingController.text),
        "minTenth": double.parse(tenthTextEditingController.text),
        "minTwelfth": double.parse(twelfthTextEditingController.text),
        "description": descriptionTextEditingController.text,
        "deadline": deadlineTextEditingController.text,
        "salary": double.parse(lpaTextEditingController.text),
        "testDate": testDateTextEditingController.text,
        "branches": [1, 2] //TODO
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
    deadlineTextEditingController.clear();
    lpaTextEditingController.clear();
    testDateTextEditingController.clear();
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
                      controller: deadlineTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Deadline",
                      ),
                    ),
                    TextFormField(
                      controller: lpaTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Salary",
                      ),
                    ),
                    TextFormField(
                      controller: testDateTextEditingController,
                      decoration: InputDecoration(
                        hintText: "TestDate",
                      ),
                    ),
                    TextFormField(
                      controller: descriptionTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(message),
                    SizedBox(height: 16),
                    GestureDetector(
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
