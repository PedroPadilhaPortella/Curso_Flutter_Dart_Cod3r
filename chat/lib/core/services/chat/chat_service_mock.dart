import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _messages = [
    //Mensagens de mock
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Pedro',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Como estamos?',
      createdAt: DateTime.now(),
      userId: '124',
      userName: 'Fernando',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'O QA está tentando o projeto',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Pedro',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Beleza, qualquer novidade, me avisa.',
      createdAt: DateTime.now(),
      userId: '124',
      userName: 'Fernando',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final Stream<List<ChatMessage>> _messagesStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() => _messagesStream;

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final ChatMessage message = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _messages.add(message);
    _controller?.add(_messages);
    return message;
  }
}
