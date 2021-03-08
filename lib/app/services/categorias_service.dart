import 'package:cuidapet_curso/app/models/categoria_model.dart';
import 'package:cuidapet_curso/app/repository/categorias_repository.dart';

class CategoriasService {
  final CategoriasRepository _repository;

  CategoriasService(this._repository);

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategorias();
  }
}
