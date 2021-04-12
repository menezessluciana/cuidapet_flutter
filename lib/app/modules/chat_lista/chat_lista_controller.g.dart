// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_lista_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatListaController on _ChatControllerBase, Store {
  final _$chatFutureAtom = Atom(name: '_ChatControllerBase.chatFuture');

  @override
  ObservableFuture<List<ChatModel>> get chatFuture {
    _$chatFutureAtom.reportRead();
    return super.chatFuture;
  }

  @override
  set chatFuture(ObservableFuture<List<ChatModel>> value) {
    _$chatFutureAtom.reportWrite(value, super.chatFuture, () {
      super.chatFuture = value;
    });
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  void buscarChats() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.buscarChats');
    try {
      return super.buscarChats();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatFuture: ${chatFuture}
    ''';
  }
}
