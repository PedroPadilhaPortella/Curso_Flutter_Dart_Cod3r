import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      final message = await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              // style: TextStyle(color: Colors.grey.shade200),
              decoration: const InputDecoration(
                labelText: 'Enviar mensagem...',
                filled: true,
                fillColor: Colors.white70,
              ),
              onChanged: (msg) {
                setState(() => _message = msg);
              },
              onSubmitted: (_) {
                if (_message.trim().isNotEmpty) {
                  _sendMessage();
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
