import 'package:cuidapet_curso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_curso/app/models/access_token_model.dart';
import 'package:cuidapet_curso/app/models/facebook_model.dart';
import 'package:cuidapet_curso/app/repository/facebook_repository.dart';
import 'package:cuidapet_curso/app/repository/security_storage_repository.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  Future<void> login(bool facebookLogin, {String email, String senha}) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;
      if (!facebookLogin) {
        accessTokenModel = await _repository.login(email,
            senha: senha, facebookLogin: facebookLogin, avatar: '');
        await fireAuth.signInWithEmailAndPassword(
            email: email, password: senha);
      } else {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          accessTokenModel = await _repository.login(facebookModel.email,
              senha: senha, facebookLogin: true, avatar: facebookModel.picture);
          final facebookCredencial = FacebookAuthProvider.getCredential(
              accessToken: facebookModel.token);
          await fireAuth.signInWithCredential(facebookCredencial);
        } else {
          throw AcessoNegadoException('Acesso Negado');
        }
      }

      prefs.registerAcessToken(accessTokenModel.accessToken);
      final confirmModel = await _repository.confirmLogin();
      prefs.registerAcessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
      final userData = await _repository.recoveryDataLoggedUser();
      prefs.registerUserData(userData);
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
