import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

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

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    print('string endereco $endereco');
    var apiKey = DotEnv().env['googleApiKey'];
    print('api key $apiKey');
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    var response = await places.autocomplete(endereco);
    print('response ${response.predictions}');
    return response.predictions;
  }
}
