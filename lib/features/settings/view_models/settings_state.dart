part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsChangeAppLanguageInitialState extends SettingsState {}

class SettingsChangeAppLanguageSuccessState extends SettingsState {}

class SettingsLogoutLoadingState extends SettingsState {}

class SettingsLogoutSuccessState extends SettingsState {}

class SettingsLogoutErrorState extends SettingsState {}
