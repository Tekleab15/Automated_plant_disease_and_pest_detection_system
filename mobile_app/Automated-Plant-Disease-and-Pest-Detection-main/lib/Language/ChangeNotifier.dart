// ignore: file_names
import 'package:flutter/material.dart';
import 'Localization.dart';

class LanguageNotifier extends ChangeNotifier {
  final LocalizationService _localizationService = LocalizationService();

  Future<void> changeLanguage(String languageCode) async {
    await _localizationService.loadLanguage(languageCode);
    notifyListeners();
  }

  String translate(String key) {
    return _localizationService.translate(key);
  }

  String get currentLanguage => _localizationService.currentLanguage;
}
