import 'package:cuidapet_curso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_curso/app/repository/security_storage_repository.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  Future<void> login(String email,
      {String senha, facebookLogin = false, String avatar = ''}) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final accessTokenModel = await _repository.login(email,
          senha: senha, facebookLogin: facebookLogin, avatar: avatar);
      if (!facebookLogin) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: senha);
        prefs.registerAcessToken(accessTokenModel.accessToken);
      } else {}

      final confirmModel = await _repository.confirmLogin();
      prefs.registerAcessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no firebase $e');
      rethrow;
    } on DioError catch (e) {
      if (e.response.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      } else {
        rethrow;
      }
    } catch (e) {
      print('Erro ao fazer login $e');
      //*PASSA O ERRO PARA QUEM CHAMAR O LOGIN DO SERVICE
      rethrow;
    }
  }
}
