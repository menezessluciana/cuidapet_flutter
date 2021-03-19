import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cuidapet_curso/app/modules/agendamento/agendamento_controller.dart';
import 'package:cuidapet_curso/app/modules/agendamento/agendamento_module.dart';

void main() {
  initModule(AgendamentoModule());
  // AgendamentoController agendamento;
  //
  setUp(() {
    //     agendamento = AgendamentoModule.to.get<AgendamentoController>();
  });

  group('AgendamentoController Test', () {
    //   test("First Test", () {
    //     expect(agendamento, isInstanceOf<AgendamentoController>());
    //   });

    //   test("Set Value", () {
    //     expect(agendamento.value, equals(0));
    //     agendamento.increment();
    //     expect(agendamento.value, equals(1));
    //   });
  });
}
