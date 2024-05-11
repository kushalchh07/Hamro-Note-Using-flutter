import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamro_note_app/Notes/createnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hamro Notes",
          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: signout, icon: Icon(Icons.logout))],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("notes").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Something Error."));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Data available"));
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var note = snapshot.data!.docs[index]['note'];
                      var docId = snapshot.data!.docs[index]
                          .id; // this will get the data from database and put it on note.

                      return GestureDetector(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              note,
                              style: GoogleFonts.abel(),
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("notes")
                                      .doc(docId)
                                      .delete();
                                },
                                icon: Icon(Icons.delete_outline_outlined)),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
