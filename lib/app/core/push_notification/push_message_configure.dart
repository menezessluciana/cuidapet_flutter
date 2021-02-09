import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void configure() async{
    if(Platform.isIOS){
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    String deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }
}