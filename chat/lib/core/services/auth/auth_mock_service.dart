import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
    static final _defaultUser = ChatUser(
    id: '456',
    name: 'Ana',
    email: 'teste3@teste.com',
    imageUrl: 'assets/images/avatar.png',
  );

  /*
  Map<String, ChatUser> _users = {};
  Se deixássemos assim, toda vez que instanciássemos essa classe, seria criado um novo map, zerando os usuários.

  static Map<String, ChatUser> _users = {};
  Ao colocarmos static fazemos com que o atributo pertença à classe e não à instância.
  Assim, independentemente da instância da classe, receberemos os mesmos usuários.
  */
  static Map<String, ChatUser> _users = {
    _defaultUser.email : _defaultUser,
  };

  // Como para essa aplicação não faz sentido termos múltiplos usuários logados, usaremos o static, para que mesmo que façamos várias instâncias da classe, acessaremos o mesmo usuário.
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_defaultUser);
  }

  // Implementando os métodos de AuthService:
  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }
  /*
  Stream é uma sequência de dados, mas ao invés de termos uma sequência já pronta, em um stream os valores são gerados sob demanda.
  Quando o usuário logar, será gerado um ChatUser válido, se fizer logout, gerará um ChatUser nulo, saindo da aplicação.
  */

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }
}
