import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maxi_app6_2_shop_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("createdAt",
                descending:
                    true) // descending:mesajları aşağıdan yukarı doğru sıralamaya yarar.
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocs = chatSnapshot.data.documents;
          return ListView.builder(
              reverse:
                  true, // mesajları aşağıdan yukarı doğru sıralamaya yarar.
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) =>
                  MessageBubble(chatDocs[index]["text"]));
        });
  }
}
