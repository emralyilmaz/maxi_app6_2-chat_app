import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maxi_app6_2_shop_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("createdAt",
                descending:
                    true) // descending:mesajları aşağıdan yukarı doğru sıralamaya yarar.
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index].data()['text'],
              chatDocs[index].data()['userId'] == user.uid,
              key: ValueKey(chatDocs[index]
                  .id), // daha inceden id yerine documentID kullanılıyordu.
            ),
          );
        });
  }
}
