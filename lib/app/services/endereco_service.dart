import 'package:cuidapet_curso/app/repository/endereco_repository.dart';

class EnderecoService {
  //*PROXY PARA O REPOSITÓRIO

  final EnderecoRepository _repository;

  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    return (await _repository.buscarEnderecos()).isNotEmpty;
  }
}
