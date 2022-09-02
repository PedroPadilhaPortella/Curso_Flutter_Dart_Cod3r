import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/models/chat_notification.dart';
import 'package:chat/core/notifications/chat_notification_service.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cod3r Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.black87),
                        SizedBox(width: 10),
                        Text("Sair"),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (dynamic value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return NotificationPage();
                }));
              },
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: Colors.red.shade800,
                child: Text(
                  '${Provider.of<ChatNotificationService>(context).itemsCount}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(child: Messages()),
          NewMessages(),
        ]),
      ),
    );
  }
}
