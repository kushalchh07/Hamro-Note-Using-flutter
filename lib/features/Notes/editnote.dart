import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController noteController = TextEditingController();
  void _onpressed() async {
    await FirebaseFirestore.instance
        .collection('notes')
        .doc(Get.arguments['docId'].toString())
        .update({
      'note': noteController.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write your notes",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: null,
                controller: noteController
                  ..text = "${Get.arguments['note'].toString()}",
                style: GoogleFonts.abel(color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _onpressed,
              child: Text(
                "Update",
                style: GoogleFonts.abel(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5, // Elevation for shadow
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
