import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

final languageStateProvider =
    StateNotifierProvider<LanguageStateNotifier, LanguageState>((ref) {
  return LanguageStateNotifier();
});

class LanguageStateNotifier extends StateNotifier<LanguageState> {
  LanguageStateNotifier() : super(const LanguageState(Locale('en')));

  Future<void> loadLanguage() async {
    //TODO : change this to load selected language from cached database
    final lang = AppLocalizations.supportedLocales.first.languageCode;

    state = LanguageState(Locale(lang));
    initializeDateFormatting(lang, null);
  }

  void changeLanguage(Locale locale) {
    //TODO : save selected language to cache
    state = LanguageState(locale);
    initializeDateFormatting(locale.languageCode, null);
  }
}

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object?> get props => [locale.languageCode];
}
