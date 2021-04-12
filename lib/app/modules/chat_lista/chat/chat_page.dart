import 'package:cuidapet_curso/app/models/chat_model.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          //*CRIA LISTA SOB DEMANDA DA TELA
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (_, index) {
                  if (index % 2 == 0) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://image.freepik.com/vetores-gratis/logotipo-de-petshop-para-gatos-e-caes_9645-750.jpg'),
                      ),
                      title: Text('Nome fornecedor'),
                      subtitle: Text('Olá cliente, tudo bem?'),
                    );
                  } else {
                    return ListTile(
                      trailing: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://pet.talknmb.com.br/wp-content/uploads/2020/04/artigo_mercado-pet-food-scaled.jpg'),
                      ),
                      title: Text('Luciana Menezes', textAlign: TextAlign.end),
                      subtitle:
                          Text('Olá Pet, tudo bem?', textAlign: TextAlign.end),
                    );
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
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
                      onPressed: () {},
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
