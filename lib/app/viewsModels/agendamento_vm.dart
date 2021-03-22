//generate dataclass
//o que é uma classe do tipo data = classe que tem metodos auxiliares
//*model para trafegar dados
import 'package:meta/meta.dart';
import 'package:cuidapet_curso/app/models/fornecedor_servico_model.dart';

class AgendamentoVM {
  int fornecedor;
  DateTime dataHora;
  String nomeReserva;
  String nomePet;
  List<FornecedorServicoModel> servicos;

  AgendamentoVM({
    @required this.fornecedor,
    @required this.dataHora,
    @required this.nomeReserva,
    @required this.nomePet,
    @required this.servicos,
  });
}
