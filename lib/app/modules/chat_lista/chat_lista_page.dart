import 'dart:io';

import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_lista_controller.dart';

class ChatListaPage extends StatefulWidget {
  const ChatListaPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatListaPageState createState() => _ChatListaPageState();
}

class _ChatListaPageState
    extends ModularState<ChatListaPage, ChatListaController> {
  //use 'controller' variable to access controller
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.buscarChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Observer(builder: (_) {
        return FutureBuilder<List<ChatModel>>(
            future: controller.chatFuture,
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  return _buildListChat(snapshot);
                  break;
                default:
                  return Container();
              }
            });
      }),
    );
  }

  Widget _buildListChat(AsyncSnapshot<List<ChatModel>> snapshot) {
    final chats = snapshot.data;

    if (snapshot.hasError) {
      return Center(
        child: Text('Erro ao buscar chats'),
      );
    }

    if (snapshot.hasData && chats.isEmpty) {
      return Center(
        child: Text('Nenhum chat encontrado'),
      );
    }
    return ListView.separated(
      itemBuilder: (_, index) {
        var chat = chats[index];
        return ListTile(
          onTap: () =>
              Modular.to.pushNamed('/chat_lista/chat/', arguments: chat),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat.fornecedor.logo),
          ),
          title: Text(chat.fornecedor.nome),
          subtitle: Text(chat.nomePet ?? ''),
        );
      },
      separatorBuilder: (_, __) {
        return Divider();
      },
      itemCount: chats.length,
    );
  }
}
