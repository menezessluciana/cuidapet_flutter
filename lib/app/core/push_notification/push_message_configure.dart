import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void configure() async {
    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onmessage $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('message $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('message $message');
    });

    String deviceId = await _fcm.getToken();
    print('device id $deviceId');
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }
}
