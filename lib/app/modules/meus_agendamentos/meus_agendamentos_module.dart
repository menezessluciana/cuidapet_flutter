import 'meus_agendamentos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'meus_agendamentos_page.dart';

class MeusAgendamentosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MeusAgendamentosController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => MeusAgendamentosPage()),
      ];

  static Inject get to => Inject<MeusAgendamentosModule>.of();
}
