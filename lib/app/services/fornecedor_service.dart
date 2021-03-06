import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_model.dart';
import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet_curso/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;

  FornecedorService(this._repository);

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      EnderecoModel endereco) {
    return _repository.buscarFornecedoresProximos(
        endereco.latitude, endereco.longitude);
  }

  Future<FornecedorModel> buscarPorId(int id) {
    return _repository.buscarPorId(id);
  }

  Future<List<FornecedorServicoModel>> buscarServicosFornecedor(
      int fornecedorId) {
    return _repository.buscarServicosFornecedor(fornecedorId);
  }
}
