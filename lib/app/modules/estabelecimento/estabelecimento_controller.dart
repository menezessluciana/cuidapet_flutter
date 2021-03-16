import 'package:cuidapet_curso/app/models/fornecedor_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet_curso/app/services/fornecedor_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'estabelecimento_controller.g.dart';

@Injectable()
class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {
  final FornecedorService _fornecedorService;

  @observable
  ObservableFuture<FornecedorModel> fornecedorFuture;

  @observable
  ObservableFuture<List<FornecedorServicoModel>> fornecedorServicosFuture;

  //* ObservableList => indicar que a lista foi alterada e não o objeto em si.
  @observable
  ObservableList<FornecedorServicoModel> servicosSelecionados =
      <FornecedorServicoModel>[].asObservable();

  _EstabelecimentoControllerBase(this._fornecedorService);

  @action
  void initPage(id) {
    fornecedorFuture = ObservableFuture(_fornecedorService.buscarPorId(id));
    fornecedorServicosFuture =
        ObservableFuture(_fornecedorService.buscarServicosFornecedor(id));
  }

  @action
  void adicionarOuRemoverServico(FornecedorServicoModel servico) {
    if (servicosSelecionados.contains(servico)) {
      servicosSelecionados.remove(servico);
    } else {
      servicosSelecionados.add(servico);
    }
  }
}
