import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: AppBar(
          backgroundColor: Colors.grey[100],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () => Modular.link.pushNamed('/enderecos'),
            )
          ],
          elevation: 0,
          flexibleSpace: Stack(
            children: <Widget>[
              Container(
                height: 110,
                width: double.infinity,
                color: ThemeUtils.primaryColor,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: ScreenUtil.screenWidthDp * .9,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.search, size: 30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Text(Modular.get<AuthStore>().usuarioLogado.email),
          FlatButton(
              child: Text('logout'),
              onPressed: () async {
                await (await SharedPrefsRepository.instance).logout();
              })
        ],
      ),
    );
  }
}
