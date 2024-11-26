// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// abstract class PushNotificationService {
//   Future<void> initialize();
//   Future<String?> getToken();
//   Future<void> subscribeToTopic(String topic);
//   Future<void> unsubscribeFromTopic(String topic);
//   Stream<RemoteMessage> get onMessageReceived;
//   Future<void> requestPermission();
// }

// class FirebaseMessagingImpl implements PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   Future<void> initialize() async {
//     // Configure local notifications
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       // Remove the deprecated callback
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );

//     // Configure FCM
//     await requestPermission();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle notification tap when app is in background
//       print('Notification tapped in background: $message');
//     });

//     // Check if app was opened from a notification
//     RemoteMessage? initialMessage = await _fcm.getInitialMessage();
//     if (initialMessage != null) {
//       // Handle notification tap when app is terminated
//       print(
//           'App opened from terminated state by notification: $initialMessage');
//     }
//   }

//   // For iOS foreground notifications, you can handle them using a separate notification channel
//   void handleForegroundNotification(
//     int id,
//     String? title,
//     String? body,
//     String? payload,
//   ) {
//     // Handle iOS foreground notification
//     print('Received foreground notification: $title - $body');
//   }

//   void onDidReceiveNotificationResponse(NotificationResponse details) {
//     // Handle notification tap
//     print('Notification tapped with payload: ${details.payload}');
//   }

//   Future<void> _showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;

//     if (notification != null && android != null && Platform.isAndroid) {
//       await _flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel',
//             'High Importance Notifications',
//             channelDescription:
//                 'This channel is used for important notifications.',
//             importance: Importance.max,
//             priority: Priority.high,
//             icon: android.smallIcon,
//           ),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }

//   @override
//   Future<String?> getToken() async {
//     return await _fcm.getToken();
//   }

//   @override
//   Future<void> subscribeToTopic(String topic) async {
//     await _fcm.subscribeToTopic(topic);
//   }

//   @override
//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _fcm.unsubscribeFromTopic(topic);
//   }

//   @override
//   Stream<RemoteMessage> get onMessageReceived => FirebaseMessaging.onMessage;

//   @override
//   Future<void> requestPermission() async {
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('User granted permission: ${settings.authorizationStatus}');
//   }
// }
