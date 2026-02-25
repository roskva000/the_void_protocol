import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Default to English, but we can check system locale here if needed.
    return const Locale('en');
  }

  void toggleLocale() {
    state =
        state.languageCode == 'en' ? const Locale('tr') : const Locale('en');
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
