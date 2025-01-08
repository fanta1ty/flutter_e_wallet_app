import 'dart:ui';

import 'package:bloc/bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit()
      : super(
          const Locale('en', ''),
        );

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode, ''));
  }
}
