import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Responsável por inserir o token no header
class AuthInterceptorWrapper extends InterceptorsWrapper {
  
   @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;
    if(DotEnv().env['profile'] == 'dev'){
      print('REQUEST LOG');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('headers ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
     if(DotEnv().env['profile'] == 'dev'){
      print('RESPONSE LOG');
      print('data ${response.data}');
    }
  }

  @override
  Future onError(DioError err) async {
    print('ON ERROR LOG');
    print('error ${err.response}');
    // verificar se deu erro 403 ou 401

    return err;
  }
}