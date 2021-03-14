// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorModel _$FornecedorModelFromJson(Map<String, dynamic> json) {
  return FornecedorModel(
    json['id'] as int,
    json['nome'] as String,
    json['logo'] as String,
    json['endereco'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['model'] == null
        ? null
        : CategoriaModel.fromJson(json['model'] as Map<String, dynamic>),
  )..telefone = json['telefone'] as String;
}

Map<String, dynamic> _$FornecedorModelToJson(FornecedorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'endereco': instance.endereco,
      'telefone': instance.telefone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'model': instance.model,
    };
