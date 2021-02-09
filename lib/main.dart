import 'package:cuidapet_curso/app/core/push_notification/push_message_configure.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  //* O MAIN EXECUTA ASSIM QUE STARTA A APLICAÇÃO
  //*Inicializa o app ANTES do runApp
  WidgetsFlutterBinding.ensureInitialized();
  //*Definindo apenas uma orientação para o app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadEnv();
  PushMessageConfigure().configure();
  runApp(ModularApp(module: AppModule()));
}


Future<void> loadEnv() async {
  //essa variavel só é true quando o projeto está rodando em modo release
  const isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(isProduction ? '.env' : '.env_dev');
}