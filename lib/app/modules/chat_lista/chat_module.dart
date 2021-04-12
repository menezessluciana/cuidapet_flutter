import 'package:cuidapet_curso/app/repository/chat_repository.dart';
import 'package:cuidapet_curso/app/services/chat_service.dart';

import 'chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatRepository()),
        Bind((i) => ChatService(i.get())),
        Bind((i) => ChatController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ChatPage()),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
