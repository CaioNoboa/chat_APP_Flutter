import 'dart:io';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_firebase_service.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

// Classe para delinear métodos que precisaremos para autenticação
abstract class AuthService {
  // Pegar o usuário atual
  ChatUser? get currentUser;

  // Sempre identificando alterações no estado do usuário
  Stream<ChatUser?> get userChanges;

  // Cadastro
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  // Login
  Future<void> login(String email, String password);

  // Sair
  Future<void> logout();

  factory AuthService() {
    // return AuthMockService();
    return AuthFirebaseService();
  }
}
