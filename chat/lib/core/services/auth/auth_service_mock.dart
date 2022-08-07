import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  @override
  ChatUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<void> register(
      String nome, String email, String password, File image) async {
    throw UnimplementedError();
  }

  @override
  Stream<ChatUser?> get userChanges => throw UnimplementedError();
}
