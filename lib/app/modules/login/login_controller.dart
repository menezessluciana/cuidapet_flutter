import 'package:cuidapet_curso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_curso/app/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @observable
  bool obscureText = true;

  _LoginControllerBase(this._service);

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        await _service.login(loginController.text, senha: senhaController.text);
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        print(e);
        Get.snackbar('Erro', 'Login ou senha inválidos');
      } catch (e) {
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  @action
  void mostrarSenhaUsuario() {
    obscureText = !obscureText;
  }
}
