import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'detalhe_controller.g.dart';

@Injectable()
class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
