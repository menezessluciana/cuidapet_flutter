import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ChatService _service;
  TextEditingController mensagemController = TextEditingController();

  _ChatControllerBase(this._service);

  @observable
  ChatModel chat;

  @observable
  ObservableStream<List<ChatMsgModel>> mensagens;

  @action
  void getChat(ChatModel model) {
    chat = model;
    final msgs = _service.buscarMensagens(chat);
    mensagens = msgs.asObservable();
  }

  void enviarMensagem() {
    if (mensagemController.text.isNotEmpty) {
      _service.enviarMensagem(chat, mensagemController.text);
      mensagemController.text = '';
    }
  }
}
