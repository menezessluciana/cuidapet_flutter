import 'package:cuidapet_curso/app/models/fornecedor_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agendamento_model.g.dart';

@JsonSerializable()
class AgendamentoModel {
  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  String status;
  FornecedorModel fornecedor;
  List<FornecedorServicoModel> servicos;
  AgendamentoModel();

  factory AgendamentoModel.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgendamentoModelToJson(this);
}
