import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locale/localization/locales.dart';

class LocalizationCubit extends Cubit<Locale>{
  LocalizationCubit(): super(const Locale("en"));

  void changeLocale(String languageCode) {
    emit(Locale(languageCode));
  }

  Map<String, dynamic> getTranslations(String languageCode) {
    switch(languageCode) {
      case "de":
        return LocaleData.DE;
      case "zh":
        return LocaleData.ZH;
      case "es":
        return LocaleData.ES;
      default:
        return LocaleData.EN;
    }
  }
}