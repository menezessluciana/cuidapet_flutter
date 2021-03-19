// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estabelecimento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EstabelecimentoController on _EstabelecimentoControllerBase, Store {
  final _$fornecedorFutureAtom =
      Atom(name: '_EstabelecimentoControllerBase.fornecedorFuture');

  @override
  ObservableFuture<FornecedorModel> get fornecedorFuture {
    _$fornecedorFutureAtom.reportRead();
    return super.fornecedorFuture;
  }

  @override
  set fornecedorFuture(ObservableFuture<FornecedorModel> value) {
    _$fornecedorFutureAtom.reportWrite(value, super.fornecedorFuture, () {
      super.fornecedorFuture = value;
    });
  }

  final _$fornecedorServicosFutureAtom =
      Atom(name: '_EstabelecimentoControllerBase.fornecedorServicosFuture');

  @override
  ObservableFuture<List<FornecedorServicoModel>> get fornecedorServicosFuture {
    _$fornecedorServicosFutureAtom.reportRead();
    return super.fornecedorServicosFuture;
  }

  @override
  set fornecedorServicosFuture(
      ObservableFuture<List<FornecedorServicoModel>> value) {
    _$fornecedorServicosFutureAtom
        .reportWrite(value, super.fornecedorServicosFuture, () {
      super.fornecedorServicosFuture = value;
    });
  }

  final _$servicosSelecionadosAtom =
      Atom(name: '_EstabelecimentoControllerBase.servicosSelecionados');

  @override
  ObservableList<FornecedorServicoModel> get servicosSelecionados {
    _$servicosSelecionadosAtom.reportRead();
    return super.servicosSelecionados;
  }

  @override
  set servicosSelecionados(ObservableList<FornecedorServicoModel> value) {
    _$servicosSelecionadosAtom.reportWrite(value, super.servicosSelecionados,
        () {
      super.servicosSelecionados = value;
    });
  }

  final _$_EstabelecimentoControllerBaseActionController =
      ActionController(name: '_EstabelecimentoControllerBase');

  @override
  void initPage(dynamic id) {
    final _$actionInfo = _$_EstabelecimentoControllerBaseActionController
        .startAction(name: '_EstabelecimentoControllerBase.initPage');
    try {
      return super.initPage(id);
    } finally {
      _$_EstabelecimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void adicionarOuRemoverServico(FornecedorServicoModel servico) {
    final _$actionInfo =
        _$_EstabelecimentoControllerBaseActionController.startAction(
            name: '_EstabelecimentoControllerBase.adicionarOuRemoverServico');
    try {
      return super.adicionarOuRemoverServico(servico);
    } finally {
      _$_EstabelecimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fornecedorFuture: ${fornecedorFuture},
fornecedorServicosFuture: ${fornecedorServicosFuture},
servicosSelecionados: ${servicosSelecionados}
    ''';
  }
}
