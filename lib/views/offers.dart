import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precruitment/helper/constants.dart';
import 'package:precruitment/helper/helperfunctions.dart';
import 'package:precruitment/services/database.dart';
import 'package:precruitment/views/applyScreen.dart';

class OfferTile extends StatelessWidget {
  final String id;
  final String companyName;
  final String role;
  final Timestamp deadline;
  final double cgpa;
  final Timestamp testDate;
  final double tenth;
  final double twelfth;
  final String description;
  final String salary;

  OfferTile(
      {this.id,
      this.companyName,
      this.role,
      this.deadline,
      this.cgpa,
      this.testDate,
      this.tenth,
      this.twelfth,
      this.description,
      this.salary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplyScreen(
                    id: id,
                    cgpa: cgpa,
                    company: companyName,
                    deadline: deadline.toDate(),
                    description: description,
                    role: role,
                    salary: salary,
                    tenth: tenth,
                    twelfth: twelfth,
                    testDate: testDate.toDate(),
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 10.0),
              constraints: BoxConstraints.expand(),
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 4.0),
                    //Company name
                    Text(
                      this.companyName,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    new Container(height: 10.0),
                    // Role
                    new Text(this.role),
                    new Container(
                        margin: new EdgeInsets.symmetric(vertical: 8.0),
                        height: 2.0,
                        width: 18.0,
                        color: new Color(0xff00c6ff)),
                    new Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_alarm,
                          size: 14.0,
                        ),
                        new Container(width: 8.0),
                        // Deadline
                        new Text(
                            "${this.deadline.toDate().day} / ${this.deadline.toDate().month}"),
                        new Container(width: 24.0),
                        Icon(
                          Icons.score,
                          size: 14.0,
                        ),
                        new Container(width: 8.0),
                        // CGPA
                        new Text(this.cgpa.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                // color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                // boxShadow: <BoxShadow>[
                //   new BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 10.0,
                //     offset: new Offset(0.0, 10.0),
                //   ),
                // ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            alignment: FractionalOffset.centerLeft,
            child: Image.asset("assets/images/google.png"),
            height: 92.0,
            width: 92.0,
          )
        ],
      ),
    );
  }
}

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Stream offersStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget offersList() {
    return StreamBuilder(
      stream: offersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return OfferTile(
                    id: snapshot.data.documents[index].id,
                    cgpa: snapshot.data.documents[index].data()['minCGPA'],
                    companyName:
                        snapshot.data.documents[index].data()['company'],
                    deadline: snapshot.data.documents[index].data()['deadline'],
                    role: snapshot.data.documents[index].data()['role'],
                    description:
                        snapshot.data.documents[index].data()['description'],
                    salary: snapshot.data.documents[index]
                        .data()['salary']
                        .toString()
                        .toString(),
                    tenth: snapshot.data.documents[index].data()['minTenth'],
                    twelfth:
                        snapshot.data.documents[index].data()['minTwelfth'],
                    testDate: snapshot.data.documents[index].data()['testDate'],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      await getOffers();
    });
    super.initState();
  }

  getOffers() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    // int branch = databaseMethods.getUserByUsername(Constants.myName)['branch'];
    QuerySnapshot bsnap =
        await databaseMethods.getUserByUsername(Constants.myName);
    // print(bsnap.docs[0].data()['branch']);
    databaseMethods.getOffers(bsnap.docs[0].data()['branch']).then((value) {
      setState(() {
        offersStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return offersList();
  }
}
