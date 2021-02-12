import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  String emailUsuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPrefsRepository.instance.then((value) {
      setState(() {
        emailUsuario = value.userData?.email;
        print('teste $value');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text(emailUsuario ?? ''),
          FlatButton(
            child: Text('logout'),
            onPressed: () async =>
                (await SharedPreferences.getInstance()).clear(),
          )
        ],
      ),
    );
  }
}
