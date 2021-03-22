import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet_curso/app/services/agendamento_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:cuidapet_curso/app/viewsModels/agendamento_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'agendamento_controller.g.dart';

@Injectable()
class AgendamentoController = _AgendamentoControllerBase
    with _$AgendamentoController;

abstract class _AgendamentoControllerBase with Store {
  final AgendamentoService _agendamentoService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController petController = TextEditingController();

  @observable
  DateTime dataSelecionada = DateTime.now();

  @observable
  TimeOfDay horarioSelecionado = TimeOfDay.now();

  _AgendamentoControllerBase(this._agendamentoService);

  @action
  void alterarData(DateTime data) {
    dataSelecionada = data;
  }

  @action
  void alterarHorario(TimeOfDay horario) {
    horarioSelecionado = horario;
  }

  @action
  Future<void> salvarAgendamento(
      int estabelecimentoId, List<FornecedorServicoModel> servicos) async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        var viewModel = AgendamentoVM(
          fornecedor: estabelecimentoId,
          dataHora: DateTime(
              dataSelecionada.year,
              dataSelecionada.month,
              dataSelecionada.day,
              horarioSelecionado.hour,
              horarioSelecionado.minute,
              0),
          nomeReserva: nomeController.text,
          nomePet: petController.text,
          servicos: servicos,
        );
        await _agendamentoService.salvarAgendamento(viewModel);
        Loader.hide();
        Get.snackbar('Sucesso',
            'Agendamento realizado com sucesso, aguarde a confirmação!');
        Future.delayed(
            Duration(seconds: 3),
            () async => await Modular.to
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')));
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao realizar agendamento');
      }
    }
  }
}
