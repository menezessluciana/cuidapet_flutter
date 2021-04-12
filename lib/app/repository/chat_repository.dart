import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/chat_model.dart';

class ChatRepository {
  Future<List<ChatModel>> buscarChatsUsuario() {
    return CustomDio.authInstance.get('/chats/usuario').then((res) =>
        res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList());
  }
}
