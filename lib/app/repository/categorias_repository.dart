import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/models/categoria_model.dart';

class CategoriasRepository {
  Future<List<CategoriaModel>> buscarCategorias() async {
    return CustomDio.authInstance.get('/categorias').then((res) => res.data
        .map<CategoriaModel>((c) => CategoriaModel.fromJson(c))
        .toList());
  }
}
