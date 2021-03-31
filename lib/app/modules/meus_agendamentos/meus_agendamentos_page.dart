import 'package:cuidapet_curso/app/models/agendamento_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'meus_agendamentos_controller.dart';

class MeusAgendamentosPage extends StatefulWidget {
  const MeusAgendamentosPage({Key key}) : super(key: key);

  @override
  _MeusAgendamentosPageState createState() => _MeusAgendamentosPageState();
}

class _MeusAgendamentosPageState
    extends ModularState<MeusAgendamentosPage, MeusAgendamentosController> {
  //use 'controller' variable to access controller
  var dateFormat = DateFormat('dd/MM/yyyy');

  var status = {
    'P': 'Pendente',
    'CN': 'Confirmada',
    'F': 'Finalizada',
    'C': 'Cancelada',
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.buscarAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de agendamentos'),
      ),
      body: FutureBuilder<List<AgendamentoModel>>(
          future: controller.agendamentosFuture,
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
                    child: Text('Erro ao buscar agendamentos'),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('Nenhum agendamento encontrado'));
                }

                if (snapshot.hasData) {
                  var agendamentos = snapshot.data;
                  return ListView.builder(
                      itemCount: agendamentos.length,
                      itemBuilder: (_, index) {
                        var agendamento = agendamentos[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateFormat
                                        .format(agendamento.dataAgendamento),
                                  ),
                                ),
                                Card(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              agendamento.fornecedor.logo),
                                        ),
                                        title:
                                            Text(agendamento.fornecedor.nome),
                                        subtitle:
                                            Text(status[agendamento.status]),
                                      ),
                                      Divider(),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              agendamento.servicos.length,
                                          itemBuilder: (_, index) {
                                            var serv =
                                                agendamento.servicos[index];
                                            return ListTile(
                                              leading: Icon(Icons.looks_one,
                                                  color:
                                                      ThemeUtils.primaryColor),
                                              title: Text(serv.nome),
                                            );
                                          })
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                break;
              default:
                return Container();
            }
          }),
    );
  }
}
