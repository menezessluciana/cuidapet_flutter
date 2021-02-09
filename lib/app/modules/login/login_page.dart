import 'dart:io';

import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/shared/components/facebook_button.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'login_controller.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
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
              height: ScreenUtil.screenHeightDp < 700? 800: ScreenUtil.screenHeightDp * .95,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/login_background.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Platform.isIOS? ScreenUtil.statusBarHeight + 30 : ScreenUtil.statusBarHeight),
              //* Double infinity pode ser usado pois o pai está limitando o tamanho da largura
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset('lib/assets/images/logo.png',
                  //*SETWIDTH A LARGURA FICA PROPORCIONAL COM O TAMANHO DO DEVICE
                      width: ScreenUtil().setWidth(400), fit: BoxFit.fill),
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
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
            ),
            Container(
              width: ScreenUtil.screenWidthDp,
              padding: EdgeInsets.all(10),
              height: 60,
              child: RaisedButton(
                onPressed: () async {
                  // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'menezessluciana5@gmail.com', password: '123123');
                  // FacebookLogin().logIn(['public_profile', 'email']);
                  // final facebookLogin = FacebookLogin();
                  // final result = await facebookLogin.logIn(['email']);
                  // print(result.status);
                  // print(result.errorMessage);
                  // CustomDio.authInstance.get('https://viacep.com.br/ws/01001000/json/ds').then((res)=>print(res.data));

                  // FirebaseMessaging _fcm = FirebaseMessaging();
                  // _fcm.requestNotificationPermissions();
                  // print(await _fcm.getToken());
                },
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
            FacebookButton(),
            FlatButton(
              onPressed: (){},
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
