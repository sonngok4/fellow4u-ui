import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';

const String LANGUAGE_CODE = 'languageCode';

// Languages enum for type safety
enum Languages {
  english('en'),
  vietnamese('vi');

  final String code;
  const Languages(this.code);
}

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LANGUAGE_CODE) ?? 'en';
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return Locale(languageCode, '');
}

String translate(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}

// Extension method for easy access to translations
extension TranslateX on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this).translate(key);
  }

  AppLocalizations get loc => AppLocalizations.of(this);
}
