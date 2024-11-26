// lib/core/configs/app_config.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  static String get wsBaseUrl =>
      dotenv.env['WS_BASE_URL'] ?? 'ws://localhost:8000';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';

  // App Settings
  static const String appName = 'Fellow4U';
  static const Locale defaultLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  // Cache Settings
  static const Duration cacheDuration = Duration(days: 7);
  static const int maxCacheSize = 50; // MB

  // Timeout Settings
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;
}
