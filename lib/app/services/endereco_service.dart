import 'package:cuidapet_curso/app/repository/endereco_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  //*PROXY PARA O REPOSITÓRIO

  final EnderecoRepository _repository;

  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    return (await _repository.buscarEnderecos()).isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecoGooglePlaces(endereco);
  }
}
