import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);
  Future<List<ChatModel>> buscarChats() {
    return _repository.buscarChatsUsuario();
  }
}
