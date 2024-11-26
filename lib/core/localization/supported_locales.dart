import 'package:flutter/material.dart';

// Define supported locales for the app
const List<Locale> supportedLocales = [
  Locale('en', 'US'), // English
  Locale('vi', 'VN'), // Vietnamese
  // Add more locales as needed
];

// Helper method to get the display name of a locale
String getDisplayLanguage(String languageCode) {
  switch (languageCode) {
    case 'en':
      return 'English';
    case 'vi':
      return 'Việt Nam';
    default:
      return languageCode;
  }
}

// Helper method to get the flag emoji for a locale
String getLanguageFlag(String languageCode) {
  switch (languageCode) {
    case 'en':
      return '🇺🇸';
    case 'vi':
      return '🇻🇳';
    default:
      return '🏳️';
  }
}

// Helper method to get locale from language code
Locale getLocaleFromLanguage(String language) {
  for (var locale in supportedLocales) {
    if (locale.languageCode == language) {
      return locale;
    }
  }
  return const Locale('en', 'US'); // Default to English
}
