import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/constants/translation/en_translation.dart';
import 'package:storyz/app/constants/translation/id_translation.dart';
import 'package:storyz/app/services/local/storage_service.dart';

class LocalizationServices extends Translations {
  static const engLocale = Locale('en', 'US');
  static const idLocale = Locale('id', 'ID');

  static final langs = ["English", "Indonesian"];
  static final iconLangs = [
    AssetsPaths.icons.englishFlag,
    AssetsPaths.icons.indonesianFlag,
  ];

  //supported locale
  static const locales = [engLocale, idLocale];

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    StorageServices().setLanguage(lang);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) {
        return locales[i];
      }
    }
    return Get.locale;
  }

  @override
  Map<String, Map<String, String>> get keys => {'id_ID': id, 'en_US': en};
}
