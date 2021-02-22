import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'enderecos_controller.dart';

class EnderecosPage extends StatefulWidget {
  final String title;
  const EnderecosPage({Key key, this.title = "Enderecos"}) : super(key: key);

  @override
  _EnderecosPageState createState() => _EnderecosPageState();
}

class _EnderecosPageState
    extends ModularState<EnderecosPage, EnderecosController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Adicione ou escolha um endereço',
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                //*Utilizando material para inserir elevation no typeaheadfield, que por default não tem essa caracteristica.
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.location_on, color: Colors.black),
                            hintText: 'Insira um endereço',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                          ),
                        ),
                        suggestionsCallback: (String pattern) {},
                        itemBuilder: (BuildContext context, itemData) {
                          return Container();
                        },
                        onSuggestionSelected: (suggestion) {}),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.near_me, color: Colors.white),
                    radius: 30,
                    backgroundColor: Colors.red,
                  ),
                  title: Text('Localização Atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  //*skrinkwrap = true pois está dentro de uma column
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildItemEndereco(),
                  itemCount: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Icon(Icons.location_on, color: Colors.black),
          backgroundColor: Colors.white,
        ),
        title: Text('Av Paulista, 100'),
        subtitle: Text('Sala 21'),
      ),
    );
  }
}
