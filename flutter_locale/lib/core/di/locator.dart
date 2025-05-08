import 'package:flutter_locale/cubits/localization_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<LocalizationCubit>(LocalizationCubit());
}