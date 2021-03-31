import 'package:cuidapet_curso/app/models/agendamento_model.dart';
import 'package:cuidapet_curso/app/services/agendamento_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'meus_agendamentos_controller.g.dart';

@Injectable()
class MeusAgendamentosController = _MeusAgendamentosControllerBase
    with _$MeusAgendamentosController;

abstract class _MeusAgendamentosControllerBase with Store {
  final AgendamentoService _agendamentoService;

  _MeusAgendamentosControllerBase(this._agendamentoService);

  @observable
  ObservableFuture<List<AgendamentoModel>> agendamentosFuture;

  @action
  void buscarAgendamentos() {
    agendamentosFuture =
        ObservableFuture(_agendamentoService.buscarAgendamentos());
  }
}
