import 'package:cuidapet_curso/app/models/categoria_model.dart';
import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/services/categorias_service.dart';
import 'package:cuidapet_curso/app/services/endereco_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoService _enderecoService;
  final CategoriasService _categoriasService;

  @observable
  EnderecoModel enderecoSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  _HomeControllerBase(this._enderecoService, this._categoriasService);

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    await buscarCategorias();
  }

  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    enderecoSelecionado = await prefs.enderecoSelecionado;
  }

  @action
  void buscarCategorias() {
    categoriasFuture = ObservableFuture(_categoriasService.buscarCategorias());
  }

  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();
    //*Não deve ser possivel acessar a página home sem endereço
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }
}
