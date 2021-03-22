import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet_curso/app/shared/components/cuidapet_textformfield.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'agendamento_controller.dart';

class AgendamentoPage extends StatefulWidget {
  final int estabelecimento;
  final List<FornecedorServicoModel> servicos;
  const AgendamentoPage(
      {Key key, @required this.estabelecimento, @required this.servicos})
      : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState
    extends ModularState<AgendamentoPage, AgendamentoController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    var formatReal = NumberFormat.currency(locale: 'pt', symbol: 'R\$');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Escolha uma data'),
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Observer(builder: (_) {
                return CalendarCarousel(
                  locale: 'pt_BR',
                  headerTextStyle:
                      TextStyle(color: ThemeUtils.primaryColor, fontSize: 25),
                  iconColor: ThemeUtils.primaryColor,
                  height: 400,
                  customGridViewPhysics: NeverScrollableScrollPhysics(),
                  selectedDateTime: controller.dataSelecionada,
                  onDayPressed: (day, _) {
                    controller.alterarData(day);
                  },
                );
              }),
              FlatButton(
                onPressed: () async {
                  var horario = await showTimePicker(
                      context: context,
                      initialTime: controller.horarioSelecionado);
                  controller.alterarHorario(horario);
                },
                textColor: ThemeUtils.primaryColor,
                child: Column(
                  children: <Widget>[
                    Text('Selecione um horário'),
                    Observer(builder: (_) {
                      return Text(
                        '${controller.horarioSelecionado.hour}: ${controller.horarioSelecionado.minute}',
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Serviços',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.servicos.length,
                    itemBuilder: (_, index) {
                      var s = widget.servicos[index];
                      return ListTile(
                        title: Text(s.nome),
                        subtitle: Text(formatReal.format(s.valor)),
                      );
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'Dados para reserva',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Seu nome',
                        controller: controller.nomeController,
                        validator: (String valor) {
                          if (valor.isEmpty) {
                            return 'Nome obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Nome do Pet',
                        controller: controller.petController,
                        validator: (String valor) {
                          if (valor.isEmpty) {
                            return 'Nome do pet obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                width: ScreenUtil.screenWidthDp * 0.9,
                height: 60,
                child: RaisedButton(
                  color: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () => controller.salvarAgendamento(
                      widget.estabelecimento, widget.servicos),
                  child: Text('Agendar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
