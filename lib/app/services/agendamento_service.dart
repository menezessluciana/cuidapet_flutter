import 'package:cuidapet_curso/app/repository/agendamento_repository.dart';
import 'package:cuidapet_curso/app/viewsModels/agendamento_vm.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;

  AgendamentoService(this._repository);

  Future<void> salvarAgendamento(AgendamentoVM agendamento) async {
    await _repository.salvarAgendamento(agendamento);
  }
}
