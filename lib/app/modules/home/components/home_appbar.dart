import 'package:cuidapet_curso/app/modules/home/home_controller.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomeAppBar extends PreferredSize {
  final HomeController controller;
  HomeAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 100),
          child: AppBar(
            backgroundColor: Colors.grey[100],
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () async {
                  //*Quando o usuário sair da tela de endereço, chama o metodo para recuperar o endereço selecionado
                  await Modular.to.pushNamed('/home/enderecos');
                  await controller.recuperarEnderecoSelecionado();
                  controller.buscarEstabelecimentos();
                },
              ),
            ],
            elevation: 0,
            flexibleSpace: Stack(
              children: <Widget>[
                Container(
                  height: 110,
                  width: double.infinity,
                  color: ThemeUtils.primaryColor,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: ScreenUtil.screenWidthDp * .9,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(30),
                      child: Observer(builder: (_) {
                        return TextFormField(
                          onChanged: (nome) =>
                              controller.filtrarEstabelecimentoPorNome(),
                          controller: controller.filtroNomeController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.search, size: 30),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
}
