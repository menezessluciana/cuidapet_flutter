import 'package:cuidapet_curso/app/services/endereco_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoService _enderecoService;

  _HomeControllerBase(this._enderecoService);

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
  }

  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();
    //*Não deve ser possivel acessar a página home sem endereço
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }
}
