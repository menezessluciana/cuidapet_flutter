//# REPOSITORY = ACESSO A DADOS
import 'dart:io';

import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/access_token_model.dart';
import 'package:cuidapet_curso/app/models/confirm_login_model.dart';
import 'package:cuidapet_curso/app/models/usuario_model.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  //Password é opcional pois o usuário pode logar com o facebook
  Future<AccessTokenModel> login(String email,
      {String senha, facebookLogin = false, String avatar = ''}) {
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': senha,
      'facebookLogin': facebookLogin,
      'avatar': avatar,
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null,
    }).then((res) => ConfirmLoginModel.fromJson(res.data));
  }

  Future<UsuarioModel> recoveryDataLoggedUser() {
    return CustomDio.authInstance
        .get('/usuario')
        .then((res) => UsuarioModel.fromJson(res.data));
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await CustomDio.instance.post('/login/cadastrar', data: {
      'email': email,
      'senha': senha,
    });
  }

  Future<UsuarioModel> atualizarImagePerfil(String urlImagem) {
    return CustomDio.authInstance.put('/usuario/avatar', data: {
      'url_avatar': urlImagem
    }).then((res) => UsuarioModel.fromJson(res.data));
  }
}
