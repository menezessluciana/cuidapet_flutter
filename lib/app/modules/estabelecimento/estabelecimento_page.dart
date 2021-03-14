import 'package:cuidapet_curso/app/models/fornecedor_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'estabelecimento_controller.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int estabelecimentoId;
  const EstabelecimentoPage({Key key, @required this.estabelecimentoId})
      : super(key: key);

  @override
  _EstabelecimentoPageState createState() => _EstabelecimentoPageState();
}

class _EstabelecimentoPageState
    extends ModularState<EstabelecimentoPage, EstabelecimentoController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initPage(widget.estabelecimentoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<FornecedorModel>(
          future: controller.fornecedorFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao buscar dados do fornecedor'),
                  );
                }

                if (snapshot.hasData) {
                  var fornec = snapshot.data;
                  return CustomScrollView(
                    slivers: <Widget>[
                      //Appbar com movimentação
                      SliverAppBar(
                        expandedHeight: 300,
                        pinned: true,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(fornec.nome),
                          stretchModes: [
                            StretchMode.zoomBackground,
                            StretchMode.fadeTitle,
                          ],
                          background: Image.network(fornec.logo),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informações do Estabelecimento',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: fornec.endereco))
                                  .then((_) => {
                                        Get.snackbar(
                                            'Cópia', 'Endereço copiado!'),
                                      });
                            },
                            leading:
                                Icon(Icons.location_city, color: Colors.black),
                            title: Text(fornec.endereco),
                          ),
                          ListTile(
                            onTap: () async {
                              if (await canLaunch('tel:${fornec.telefone}')) {
                                await launch('tel:${fornec.telefone}');
                              } else {
                                Clipboard.setData(
                                        ClipboardData(text: fornec.telefone))
                                    .then((_) => {
                                          Get.snackbar(
                                              'Cópia', 'Telefone copiado!'),
                                        });
                              }
                            },
                            leading:
                                Icon(Icons.local_phone, color: Colors.black),
                            title: Text(fornec.telefone),
                          ),
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Serviços(0 selecionado)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(child: Icon(Icons.pets)),
                                title: Text('Banho'),
                                subtitle: Text('R\$ 20,00'),
                                trailing: Icon(Icons.add_circle,
                                    color: ThemeUtils.primaryColor, size: 30),
                              );
                            },
                          ),
                        ]),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text('Nenhum dado encontrado'),
                );
                break;
              default:
                return Container();
            }
          }),
    );
  }

  Future<void> customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }
}
