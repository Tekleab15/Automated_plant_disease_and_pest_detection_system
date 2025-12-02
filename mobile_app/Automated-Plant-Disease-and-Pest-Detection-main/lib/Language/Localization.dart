// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationService {
  static final LocalizationService _instance = LocalizationService._internal();
  factory LocalizationService() => _instance;

  LocalizationService._internal();

  Map<String, String> _localizedStrings = {};
  String _currentLanguage = 'en';

  Future<void> loadLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    String jsonString =
        await rootBundle.loadString('assets/lang/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  String get currentLanguage => _currentLanguage;
}
