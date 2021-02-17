import 'dart:io';
import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:cuidapet_curso/app/shared/components/facebook_button.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
    testeConnection();
  }

  void testeConnection() async {
    var db = await Connection().instance;
    var resultado = await db.rawQuery('select * from endereco');
    print('RESULTADO QUERY $resultado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        child: Stack(
          children: [
            Container(
              width: ScreenUtil.screenWidthDp,
              height: ScreenUtil.screenHeightDp < 700
                  ? 800
                  : ScreenUtil.screenHeightDp * .95,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/login_background.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Platform.isIOS
                      ? ScreenUtil.statusBarHeight + 30
                      : ScreenUtil.statusBarHeight),
              //* Double infinity pode ser usado pois o pai está limitando o tamanho da largura
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset('lib/assets/images/logo.png',
                      //*SETWIDTH A LARGURA FICA PROPORCIONAL COM O TAMANHO DO DEVICE
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.fill),
                  _buildForm()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
                controller: controller.loginController,
                decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Login obrigatório';
                  }
                  return null;
                }),
            SizedBox(height: 20),
            Observer(builder: (_) {
              return TextFormField(
                  controller: controller.senhaController,
                  obscureText: controller.obscureText,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        gapPadding: 0,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () => controller.mostrarSenhaUsuario(),
                          icon: controller.obscureText
                              ? Icon(Icons.lock)
                              : Icon(Icons.lock_open))),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Senha obrigatória';
                    } else if (value.length < 6) {
                      return 'Senha precisa ter pelo menos 6 caracteres';
                    }
                    return null;
                  });
            }),
            Container(
              width: ScreenUtil.screenWidthDp,
              padding: EdgeInsets.all(10),
              height: 60,
              child: RaisedButton(
                onPressed: () => controller.login(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: ThemeUtils.primaryColor,
                child: Text('Entrar',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('ou',
                        style: TextStyle(
                            color: ThemeUtils.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(onTap: () => controller.facebookLogin()),
            FlatButton(
              onPressed: () => Modular.link.pushNamed('/cadastro'),
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
