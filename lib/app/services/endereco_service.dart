import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:cuidapet_curso/app/repository/enderecos_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  //*PROXY PARA O REPOSITÓRIO

  final EnderecosRepository _repository;

  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    return (await _repository.buscarEnderecos()).isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecoGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel endereco) async {
    await _repository.salvarEndereco(endereco);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() async {
    return await _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> buscarDetalheEnderecoGooglePlaces(
      String placeId) {
    return _repository.recuperarDetalhesEnderecoGooglePlaces(placeId);
  }

  Future<void> limparEnderecos() async {
    await _repository.limparEnderecosCadastrados();
  }
}
