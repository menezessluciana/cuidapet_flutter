import 'package:cuidapet_curso/app/modules/login/login_controller.dart';
import 'package:cuidapet_curso/app/services/usuario_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'cadastro_controller.g.dart';

@Injectable()
class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool obscureTextSenha = true;

  @observable
  bool obscureTextConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void mostrarSenhaUsuario() => obscureTextSenha = !obscureTextSenha;

  @action
  void mostrarConfirmaSenhaUsuario() =>
      obscureTextConfirmaSenha = !obscureTextConfirmaSenha;

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        await _service.cadastrarUsuario(
            loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } catch (e) {
        print(e);
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao cadastrar usuário');
      }
    }
  }
}
