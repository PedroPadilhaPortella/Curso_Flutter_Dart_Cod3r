import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final currentUser = AuthService().currentUser;

  Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ainda não há mensagens aqui...'),
                const Text('Envie uma nova mensagem'),
              ]);
        } else {
          final messages = snapshot.data!;
          return ListView.builder(
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (ctx, i) {
              return MessageBubble(
                  key: ValueKey(messages[i].id),
                  message: messages[i],
                  belongsToCurrentUser: currentUser!.id == messages[i].userId);
            },
          );
        }
      },
    );
  }
}
