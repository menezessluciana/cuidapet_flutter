import 'package:cuidapet_curso/app/models/fornecedor_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: controller.servicosSelecionados.isNotEmpty ? 1 : 0,
          child: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed('/agendamento', arguments: {
              'estabelecimentoId': widget.estabelecimentoId,
              'servicosSelecionados': controller.servicosSelecionados
            }),
            label: Text('Fazer agendamento'),
            icon: Icon(Icons.schedule),
            backgroundColor: ThemeUtils.primaryColor,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder<FornecedorModel>(
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
                          leading: Icon(Icons.local_phone, color: Colors.black),
                          title: Text(fornec.telefone),
                        ),
                        Divider(
                          thickness: 1,
                          color: ThemeUtils.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return Text(
                              'Serviços(${controller.servicosSelecionados.length} selecionado${controller.servicosSelecionados.length > 1 ? 's' : ''})',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            );
                          }),
                        ),
                        buildServicos(),
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
        });
  }

  Widget buildServicos() {
    var formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorServicoModel>>(
          future: controller.fornecedorServicosFuture,
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
                    child: Text('Erro ao buscar serviços do fornecedor'),
                  );
                }

                if (snapshot.hasData) {
                  var servicos = snapshot.data;
                  return Observer(builder: (_) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          bottom: controller.servicosSelecionados.isNotEmpty
                              ? 50
                              : 0),
                      itemCount: servicos.length,
                      itemBuilder: (context, index) {
                        var servico = servicos[index];
                        return Observer(builder: (_) {
                          return ListTile(
                            leading: CircleAvatar(child: Icon(Icons.pets)),
                            title: Text(servico.nome),
                            subtitle: Text(formatReal.format(servico.valor)),
                            trailing: IconButton(
                              icon: controller.servicosSelecionados
                                      .contains(servico)
                                  ? Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: ThemeUtils.primaryColor,
                                      size: 30,
                                    ),
                              onPressed: () {
                                controller.adicionarOuRemoverServico(servico);
                              },
                            ),
                          );
                        });
                      },
                    );
                  });
                }
                return Center(
                  child: Text('Nenhum dado encontrado'),
                );
                break;
              default:
                return Container();
            }
          });
    });
  }
}
