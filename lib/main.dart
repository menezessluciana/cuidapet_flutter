import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  //*Inicializa o app ANTES do runApp
  WidgetsFlutterBinding.ensureInitialized();
  //*Definindo apenas uma orientação para o app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ModularApp(module: AppModule()));
}
