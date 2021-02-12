import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  String email;
  String avatar;
  String imgAvatar;

  UsuarioModel({
    this.email,
    this.avatar,
    this.imgAvatar,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
