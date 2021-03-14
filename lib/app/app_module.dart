import 'package:cuidapet_curso/app/core/database/connection_adm.dart';
import 'package:cuidapet_curso/app/modules/estabelecimento/estabelecimento_module.dart';
import 'package:cuidapet_curso/app/repository/enderecos_repository.dart';
import 'package:cuidapet_curso/app/repository/fornecedor_repository.dart';
import 'package:cuidapet_curso/app/repository/usuario_repository.dart';
import 'package:cuidapet_curso/app/services/endereco_service.dart';
import 'package:cuidapet_curso/app/services/fornecedor_service.dart';
import 'package:cuidapet_curso/app/services/usuario_service.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_widget.dart';
import 'package:cuidapet_curso/app/shared/auth_store.dart';

import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/main_page/main_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConnectionAdm(), lazy: false),
        Bind((i) => AppController()),
        Bind((i) => AuthStore()),
        Bind((i) => EnderecosRepository()),
        Bind((i) => EnderecoService(i.get())),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => FornecedorRepository()),
        Bind((i) => FornecedorService(i.get()))
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MainPage(),
        ),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/estabelecimento', module: EstabelecimentoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
