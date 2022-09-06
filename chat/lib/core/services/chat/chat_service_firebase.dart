import 'dart:async';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() =>
      Stream<List<ChatMessage>>.empty();

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final storage = FirebaseFirestore.instance;

    // ChatMessage -> Map<String, dynamic>
    final docRef = await storage.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl,
    });

    // Map<String, dynamic> -> ChatMessage
    final snapshot = await docRef.get();
    final data = snapshot.data()!;

    return ChatMessage(
      id: snapshot.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
    );
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
