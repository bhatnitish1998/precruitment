import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:precruitment/widgets/file_view.dart';

class AluminiScreen extends StatelessWidget {
  static final routeName = "/alumini";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("file_links").snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return FileView(snapshot.data.documents[index]['fileName'],
                      snapshot.data.documents[index]['fileUrl']);
                },
              )
            : Container(
                child: Center(
                  child: Text("No files available."),
                ),
              );
      },
    );
  }
}

void filePicker() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('alumini_files')
        .child(file.name);
    await ref.putFile(File(file.path));
    final fileUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("file_links").add({
      'fileUrl': fileUrl.toString(),
      'fileName': file.name.toString(),
      'fileExtension': file.extension.toString()
    });
  } else {
    // User canceled the picker
  }
}
