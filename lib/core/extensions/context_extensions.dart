import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_cubit.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  bool get isDark => watch<ThemeCubit>().state == ThemeMode.dark;

  ColorScheme get scheme => Theme.of(this).colorScheme;
}
