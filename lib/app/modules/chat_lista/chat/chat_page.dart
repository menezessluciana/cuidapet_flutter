import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:cuidapet_curso/app/models/chat_msg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;
  const ChatPage({Key key, this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(this.chat);
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  //use 'controller' variable to access controller'
  //
  final ChatModel model;

  _ChatPageState(this.model);

  @override
  void initState() {
    controller.getChat(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                final List<ChatMsgModel> msgs = controller.mensagens?.data;

                if (msgs == null) return SizedBox.shrink();
                //*CRIA LISTA SOB DEMANDA DA TELA
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: msgs.length,
                    itemBuilder: (_, index) {
                      final msg = msgs[index];
                      if (msg.fornecedor != null) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(model.fornecedor.logo),
                          ),
                          title: Text(model.fornecedor.nome),
                          subtitle: Text(msg.mensagem),
                        );
                      } else {
                        return ListTile(
                          trailing: CircleAvatar(),
                          title: Text(model.nome, textAlign: TextAlign.end),
                          subtitle:
                              Text(msg.mensagem, textAlign: TextAlign.end),
                        );
                      }
                    });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.mensagemController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    minRadius: 25,
                    child: IconButton(
                      onPressed: () => controller.enviarMensagem(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
