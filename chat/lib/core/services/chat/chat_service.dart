import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chart_firebase_service.dart';
import 'package:chat/core/services/chat/chart_mock_service.dart';

abstract class ChatService {
  // Ao trabalharmos com Stream com as mensagens, sempre que chegar uma nova mensagem, automaticamente receberemos esses valores
  Stream<List<ChatMessage>> messagesStream();

  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    // return ChatMockService();
    return ChatFirebaseService();
  }
}
