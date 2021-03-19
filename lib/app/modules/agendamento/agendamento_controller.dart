import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'agendamento_controller.g.dart';

@Injectable()
class AgendamentoController = _AgendamentoControllerBase
    with _$AgendamentoController;

abstract class _AgendamentoControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
