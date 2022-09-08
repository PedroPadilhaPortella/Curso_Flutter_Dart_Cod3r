import 'dart:async';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final storage = FirebaseFirestore.instance;
    final snapshots = storage
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createdAt', descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final storage = FirebaseFirestore.instance;
    final message = ChatMessage(
      id: '',
      createdAt: DateTime.now(),
      userId: user.id,
      text: text,
      userImageUrl: user.imageUrl,
      userName: user.name,
    );

    final docRef = await storage
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(message);

    final snapshot = await docRef.get();
    final data = snapshot.data()!;
    return data;
  }

  // Map<String, dynamic> => ChatMessage
  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
        id: doc.id,
        text: doc['text'],
        createdAt: DateTime.parse(doc['createdAt']),
        userId: doc['userId'],
        userName: doc['userName'],
        userImageUrl: doc['userImageURL']);
  }

  // ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      "text": msg.text,
      "createdAt": msg.createdAt.toIso8601String(),
      "userId": msg.userId,
      "userName": msg.userName,
      "userImageURL": msg.userImageUrl,
    };
  }
}
