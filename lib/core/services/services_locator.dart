import 'package:get_it/get_it.dart';
import '/features/home/model/repository/home_repository.dart';
import '/features/home/model/repository/home_repository_impl.dart';
import '/features/home/view_models/home_cubit.dart';
import '/features/branches_details/model/repository/organization_details_repository.dart';
import '/features/branches_details/model/repository/organization_details_repository_impl.dart';
import '/features/branches_details/view_model/organization_details_cubit.dart';
import '/features/settings/model/repository/settings_repository.dart';
import '/features/settings/model/repository/settings_repository_impl.dart';
import '/features/settings/view_models/settings_cubit.dart';
import '/features/tokens/model/repository/tokens_repository.dart';
import '/features/tokens/model/repository/tokens_repository_impl.dart';
import '/features/tokens/view_model/tokens_cubit.dart';
import '/features/auth/model/repository/auth_repository.dart';
import '/features/auth/model/repository/auth_repository_impl.dart';
import '/features/auth/view_model/auth_cubit.dart';
import '/features/onboarding/view_model/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/services/app_prefs.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// Initialize SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);

    /// Initialize AppPreferences
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences());

    /// Blocs
    sl.registerFactory(() => OnBoardingCubit());
    sl.registerFactory(() => AuthCubit(sl<AuthRepository>()));
    sl.registerFactory(() => HomeCubit(sl<HomeRepository>()));
    sl.registerFactory(() => SettingsCubit(sl<SettingsRepository>()));
    sl.registerFactory(
      () => TokensCubit(
        sl<TokensRepository>(),
        sl<OrganizationDetailsRepository>(),
      ),
    );
    sl.registerFactory(
        () => OrganizationDetailsCubit(sl<OrganizationDetailsRepository>()));

    /// Repositories
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
    sl.registerLazySingleton<TokensRepository>(() => TokensRepositoryImpl());
    sl.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl());
    sl.registerLazySingleton<OrganizationDetailsRepository>(
        () => OrganizationDetailsRepositoryImpl());
  }
}
