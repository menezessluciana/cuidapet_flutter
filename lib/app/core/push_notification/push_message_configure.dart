import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void configure() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.example.cuidapet_curso', 'cuidapet_curso', 'Cuidapet',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    final iOSPlataformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlataformChannelSpecifics);

    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.onIosSettingsRegistered.listen((settings) {
        print('Configurações do iOS registrada $settings');
      });
    }

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onmessage $message');
      await _flutterLocalNotificationsPlugin.show(
          99,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics);
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

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(title);
  }
}
