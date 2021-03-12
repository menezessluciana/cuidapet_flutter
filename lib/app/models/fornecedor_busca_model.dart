import 'package:json_annotation/json_annotation.dart';

import 'categoria_model.dart';

part 'fornecedor_busca_model.g.dart';

@JsonSerializable()
class FornecedorBuscaModel {
  int id;
  String nome;
  String logo;
  double distancia;
  CategoriaModel categoria;

  FornecedorBuscaModel();

  factory FornecedorBuscaModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorBuscaModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorBuscaModelToJson(this);
}
