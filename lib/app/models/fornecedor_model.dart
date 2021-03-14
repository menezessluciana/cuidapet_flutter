import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_curso/app/models/categoria_model.dart';

part 'fornecedor_model.g.dart';

@JsonSerializable()
class FornecedorModel {
  int id;
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoriaModel model;

  FornecedorModel(
    this.id,
    this.nome,
    this.logo,
    this.endereco,
    this.latitude,
    this.longitude,
    this.model,
  );

  factory FornecedorModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorModelToJson(this);
}
