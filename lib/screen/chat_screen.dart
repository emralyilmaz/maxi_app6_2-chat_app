import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("This works!"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/mOuuVqS7tDSSNeo8NoIX/messages")
              .snapshots()
              .listen((data) {
            data.docs.forEach((document) {
              print(document["text"]);
            });
          });
        },
      ),
    );
  }
}
