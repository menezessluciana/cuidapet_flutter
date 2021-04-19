import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:cuidapet_curso/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);
  Future<List<ChatModel>> buscarChats() {
    return _repository.buscarChatsUsuario();
  }

  Stream<List<ChatMsgModel>> buscarMensagens(ChatModel chat) {
    return _repository.buscarMensagens(chat);
  }

  void enviarMensagem(ChatModel model, String mensagem) {
    _repository.enviarMensagemChat(model, mensagem);
    _repository.notificarUsuario(model, mensagem);
  }
}
