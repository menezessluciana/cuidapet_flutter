import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_lista_controller.g.dart';

@Injectable()
class ChatListaController = _ChatControllerBase with _$ChatListaController;

abstract class _ChatControllerBase with Store {
  final ChatService _chatService;

  _ChatControllerBase(this._chatService);

  //* Poderia utilizar apenas um future pois não há por exemplo filtro.
  @observable
  ObservableFuture<List<ChatModel>> chatFuture;

  @action
  void buscarChats() {
    chatFuture = ObservableFuture(_chatService.buscarChats());
  }
}
