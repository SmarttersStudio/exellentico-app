import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ecommerceapp/utils/notification_services/notification_tap_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/17/2020 8:16 AM
///


const String channelId = 'com.smarttersstudio.ecommerceapp/notification';
const String channelName = 'ECommerce-Notification';
const String channelDescription = 'ECommerce Notification Channel';
const String notificationTicker = 'ticker';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class InAppNotification{
    ///Configuration for flutter local notifications both android and ios
    static Future<void> configureInAppNotification({bool reqAlert = true,bool reqBadge = true, bool reqSound = true}) async {
        notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
        var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
        var initializationSettingsIOS = IOSInitializationSettings(
            requestAlertPermission: reqAlert,
            requestBadgePermission: reqBadge,
            requestSoundPermission: reqSound,
            onDidReceiveLocalNotification:
                (int id, String title, String body, String payload) async {
                onNotificationTapped(payload, title: title, desc: body);
            });
        var initializationSettings = InitializationSettings(
            initializationSettingsAndroid, initializationSettingsIOS);
        await flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: onNotificationTapped
        );
    }

    ///request IOS notification permission
    static void requestIOSPermissions({bool alert = true,bool badge = true, bool sound = true}) {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
            alert: alert,
            badge: badge,
            sound: sound,
        );
    }

    ///Shows notification from anywhere ...For more customization check AndroidNotificationDetails() below
    static Future<void> showNotification(
        {String title = 'E-commerce',
            String description = 'New notification.',
            String iconUrl = 'http://via.placeholder.com/128x128/00FF00/000000',
            String imageUrl = '',
            bool enableLights = true,
            bool enableVibration = true,
            bool playSound = true,
            int ledOnMs: 1000,
            int ledOffMs: 500,
            String groupKey = "",
            Importance importance = Importance.Max,
            bool channelShowBadge = true,
            bool autoCancel = true,
            NotificationVisibility visibility,
            Priority priority = Priority.Max,
            Color color = const Color.fromARGB(255, 255, 0, 0),
            Color ledColor = const Color.fromARGB(255, 255, 0, 0),
            Map<dynamic, dynamic> data = const {}}) async {
        var largeIconPath = await _downloadAndSaveFile(iconUrl, 'largeIcon');

        var vibrationPattern = Int64List(4);
        vibrationPattern[0] = 0;
        vibrationPattern[1] = 1000;
        vibrationPattern[2] = 5000;
        vibrationPattern[3] = 2000;
        StyleInformation styleInformation;

        if(imageUrl.isEmpty){
            styleInformation = DefaultStyleInformation(true, true);
        }else{
            var bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
            styleInformation = BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicturePath),
                largeIcon: FilePathAndroidBitmap(largeIconPath),
                contentTitle: title,
                htmlFormatContentTitle: true,
                summaryText: description,
                htmlFormatSummaryText: true);
        }
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            channelId, channelName, channelDescription,
            icon: '@mipmap/ic_launcher',
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            styleInformation: styleInformation,
            importance: importance,
            priority: priority,
            ticker: notificationTicker,
            playSound: playSound,
            vibrationPattern: vibrationPattern,
            enableLights: enableLights,
            enableVibration: enableVibration,
            color: color,
            channelShowBadge: channelShowBadge,
            autoCancel: autoCancel,
            ledColor: ledColor,
            ledOnMs: ledOnMs,
            ledOffMs: ledOffMs);
        var iOSPlatformChannelSpecifics = imageUrl.isEmpty?IOSNotificationDetails(presentSound: playSound):null;
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, title, description, platformChannelSpecifics,
            payload: json.encode(data));
    }

}

///downloads and saves the network image
Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
}
