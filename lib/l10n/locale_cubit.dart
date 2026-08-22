import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';

@lazySingleton

class LocaleCubit extends Cubit<Locale> {
  static const _boxName = 'settings';
  static const _localeKey = 'locale';

  LocaleCubit() : super(_initialLocale());

  static Locale _initialLocale() {
    return const Locale('ar');
  }

  void setEnglish() {
    emit(const Locale('en'));
    _persist('en');
  }

  void setArabic() {
    emit(const Locale('ar'));
    _persist('ar');
  }

  void toggle() {
    if (state.languageCode == 'en') {
      setArabic();
    } else {
      setEnglish();
    }
  }

  void _persist(String code) {
    try {
      final box = Hive.box<String>(_boxName);
      box.put(_localeKey, code);
    } catch (_) {}
  }
}
