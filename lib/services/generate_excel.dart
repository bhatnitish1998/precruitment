import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> createExcel(String company, String role) async {
  List<dynamic> applied;
  int base = 3;
  int count = 0;
  List heading = [
    'Sl No.',
    'USN',
    'Name',
    'Email',
    'Mobile',
    'DOB',
    'Branch',
    'BE CGPA',
    '10th %',
    '12th %',
    'College'
  ];
  List attr = [
    "name",
    "fullname",
    "personalMail",
    "phone",
    "DOB",
    "branch",
    "cgpa",
    "tenth",
    "twelfth",
  ];
// get the applied students names.
  await FirebaseFirestore.instance
      .collection('offers')
      .where('company', isEqualTo: company)
      .where('role', isEqualTo: role)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              applied = doc.data()["applied"];
              //print(applied);
            })
          });
//Create an Excel document.
  //Creating a workbook.
  final Workbook workbook = Workbook();
  //Accessing via index
  final Worksheet sheet = workbook.worksheets[0];
  // sheet.showGridlines = false;
  sheet.showGridlines = true;
  // Enable calculation for worksheet.
  sheet.enableSheetCalculations();
  //Set data in the worksheet.
  sheet.getRangeByName('A1').columnWidth = 7;
  sheet.getRangeByName('B1').columnWidth = 15;
  sheet.getRangeByName('C1:D1').columnWidth = 20;
  sheet.getRangeByName('E1:G1').columnWidth = 15;
  sheet.getRangeByName('H1:J1').columnWidth = 10;
  sheet.getRangeByName('K1').columnWidth = 25;

  sheet.getRangeByName('A1:K2').merge();
  sheet.getRangeByName('A1').setText('$company : $role');
  sheet.getRangeByName('A1').cellStyle.fontSize = 24;

  final Range range6 = sheet.getRangeByName('A$base:P$base');
  range6.cellStyle.fontSize = 10;
  range6.cellStyle.bold = true;

  var temp1 = 1;
  heading.forEach((idx) {
    sheet.getRangeByIndex(base, temp1).setText(idx);
    temp1 += 1;
  });

  base += 1;

//applied=["testdagger"];
  await FirebaseFirestore.instance
      .collection('users')
      .where('name', whereIn: applied)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              count += 1;
              var temp = 2;
              sheet.getRangeByIndex(base, 1).setText((count).toString());
              for (var i = 0; i < attr.length; i++) {
                sheet
                    .getRangeByIndex(base, temp)
                    .setText(doc.data()[attr[i]].toString());
                temp += 1;
              }
              sheet
                  .getRangeByIndex(base, (attr.length + 1))
                  .setText("KLE Technological University");
              base += 1;
            })
          });

  //Save  the excel.
  final List<int> bytes = workbook.saveAsStream();
  //Dispose the document.
  workbook.dispose();
  //Save file.
  await Permission.storage.request().isGranted;
  final directory = await DownloadsPathProvider.downloadsDirectory;
  final path = directory.path;
  final file = File('$path/$company-$role.xlsx');
  file.writeAsBytes(bytes);
  print(role);
  print(file.path);
}
