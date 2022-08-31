import 'package:chat/core/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CHAT Page'),
            TextButton(
                onPressed: () {
                  AuthServiceMock().logout();
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
