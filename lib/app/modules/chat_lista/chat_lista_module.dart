import 'package:cuidapet_curso/app/modules/chat_lista/chat/chat_module.dart';
import 'package:cuidapet_curso/app/repository/chat_repository.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';

import 'chat_lista_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_lista_page.dart';

class ChatListaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatRepository()),
        Bind((i) => ChatService(i.get())),
        Bind((i) => ChatListaController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => ChatListaPage(),
        ),
        ModularRouter('/chat', module: ChatModule()),
      ];

  static Inject get to => Inject<ChatListaModule>.of();
}
