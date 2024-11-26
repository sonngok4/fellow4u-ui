// import 'package:firebase_analytics/firebase_analytics.dart';

// abstract class AnalyticsService {
//   Future<void> logEvent({
//     required String name,
//     Map<String, Object>? parameters, // Changed from dynamic to Object
//   });

//   Future<void> setCurrentScreen(String screenName);
//   Future<void> setUserId(String? userId);
//   Future<void> setUserProperty({
//     required String name,
//     required String? value,
//   });
// }

// class FirebaseAnalyticsImpl implements AnalyticsService {
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

//   @override
//   Future<void> logEvent({
//     required String name,
//     Map<String, Object>? parameters, // Changed from dynamic to Object
//   }) async {
//     await _analytics.logEvent(
//       name: name,
//       parameters: parameters,
//     );
//   }

//   @override
//   Future<void> setCurrentScreen(String screenName) async {
//     await _analytics.logScreenView(
//       screenName: screenName,
//     );
//   }

//   @override
//   Future<void> setUserId(String? userId) async {
//     await _analytics.setUserId(id: userId);
//   }

//   @override
//   Future<void> setUserProperty({
//     required String name,
//     required String? value,
//   }) async {
//     await _analytics.setUserProperty(
//       name: name,
//       value: value,
//     );
//   }
// }
