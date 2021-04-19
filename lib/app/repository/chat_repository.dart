import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';

class ChatRepository {
  //conexao com o firebase
  final Firestore _firestore = Firestore.instance;

  Future<List<ChatModel>> buscarChatsUsuario() {
    return CustomDio.authInstance.get('/chats/usuario').then((res) =>
        res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList());
  }

  //Chats ficam gravados no backend mas as mensagens ficam no firebase
  //Stream = recebe sempre atualizações
  Stream<List<ChatMsgModel>> buscarMensagens(ChatModel chat) {
    return _firestore
        .collection('chat')
        .document(chat.id.toString())
        .collection('messages')
        .orderBy('data_mensagem', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.documents
          .map((m) => ChatMsgModel(
              usuario: m['usuario'],
              fornecedor: m['fornecedor'],
              mensagem: m['mensagem']))
          .toList();
    });
  }
}
