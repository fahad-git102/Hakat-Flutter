
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../constants/lang/strings.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('nl', 'NL');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static const langs = [
    'English',
    'Dutch'
  ];

  // Supported locales
  // Needs to be same order with langs
  static const locales = [
    Locale('en', 'US'),
    Locale('nl', 'NL'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': Messages.enUS,  // lang/ja_jp.dart
    'nl_NL': Messages.nlNL,  // lang/ja_jp.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}