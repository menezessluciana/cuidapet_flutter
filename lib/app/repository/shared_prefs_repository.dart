// Classe singleton - COM APENAS 1 INSTANCIA PARA O APP TODO
import 'dart:convert';

import 'package:cuidapet_curso/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _USER_DATA = '/_USER_DATA/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  //* vai guardar o accesstoken
  void registerAcessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  void registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  void registerUserData(UsuarioModel usuario) async {
    //*JSON ENCODE = Transforma um map em uma string
    await prefs.setString(_USER_DATA, jsonEncode(usuario));
  }

  UsuarioModel get userData {
    //* Não pode passar um valor null pro jsonDecode
    if (prefs.containsKey(_USER_DATA)) {
      //*JSON DECODE = Transforma string em um Map<String, dynamic>
      Map<String, dynamic> userMap = jsonDecode(prefs.getString(_USER_DATA));
      return UsuarioModel.fromJson(userMap);
    }
    return null;
  }
}
