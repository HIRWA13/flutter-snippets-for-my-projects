import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locale/core/di/locator.dart';
import 'package:flutter_locale/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;

import 'cubits/localization_cubit.dart';

main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCubit = getIt<LocalizationCubit>();

    return BlocBuilder<LocalizationCubit, Locale>(
      bloc: localizationCubit,
      builder: (context, locale) {
        return MaterialApp(
          locale: locale,
          supportedLocales: [
            Locale("en"),
            Locale("de"),
            Locale("zh"),
            Locale("es"),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: HomePage(),
        );
      },
    );
  }
}
