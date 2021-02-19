import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:cuidapet_curso/app/models/endereco_model.dart';

class EnderecoRepository {
  Future<List<EnderecoModel>> buscarEnderecos() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery('select * from endereco');
    return result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('insert into endereco values(?, ?, ?, ?, ?)', [
      null,
      model.endereco,
      model.latitude,
      model.longitude,
      model.complemento
    ]);
  }

  //*Quando o usuário deslogar, irá resetar todos os endereços cadastrados.

  Future<void> limparEnderecosCadastrados() async {
    final conn = await Connection().instance;
    await conn.rawDelete('delete from endereco');
  }
}
