import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';

import 'package:fellow4u_ui/core/configs/app_config.dart';
import 'package:fellow4u_ui/core/network/network_info.dart';
import 'package:fellow4u_ui/core/services/navigation_service.dart';
import 'package:fellow4u_ui/core/storage/local_storage.dart';

// Auth Imports
import 'package:fellow4u_ui/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fellow4u_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:fellow4u_ui/features/auth/domain/usescases/login.dart';
import 'package:fellow4u_ui/features/auth/domain/usescases/register.dart';
import 'package:fellow4u_ui/features/auth/presentation/common/viewmodels/auth_viewmodel.dart';

// Trip Imports
import 'package:fellow4u_ui/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:fellow4u_ui/features/trips/data/datasources/trip_remote_datasource.dart';
import 'package:fellow4u_ui/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:fellow4u_ui/features/trips/domain/repositories/trip_repository.dart';
import 'package:fellow4u_ui/features/trips/presentation/provider/providers/provider_trips_provider.dart';

// Guide Imports
import 'package:fellow4u_ui/features/guide_management/data/datasources/guide_local_datasource.dart';
import 'package:fellow4u_ui/features/guide_management/data/datasources/guide_remote_datasource.dart';
import 'package:fellow4u_ui/features/guide_management/data/repositories/guide_repository_impl.dart';
import 'package:fellow4u_ui/features/guide_management/domain/repositories/guide_repository.dart';

class ServiceLocator {
  static final GetIt locator = GetIt.instance;

  static Future<void> setup() async {
    // Ensure GetIt is clear to prevent duplicate registrations
    await locator.reset();

    // Core Dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerLazySingleton(() => sharedPreferences);
    locator.registerLazySingleton(() => http.Client());
    locator.registerLazySingleton(() => InternetConnectionChecker());

    // External
    locator.registerLazySingleton(() => Dio(BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          connectTimeout: AppConfig.connectionTimeout,
          receiveTimeout: AppConfig.receiveTimeout,
          headers: {'Accept': 'application/json'},
        )));

    // Core Services
    locator
        .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
    locator
        .registerLazySingleton<LocalStorage>(() => LocalStorageImpl(locator()));
    locator.registerLazySingleton<NavigationService>(
        () => NavigationServiceImpl());

    // Guide Management
    locator.registerLazySingleton<GuideRemoteDatasource>(
      () => GuideRemoteDatasourceImpl(
        client: locator<http.Client>(),
        baseUrl: AppConfig.apiBaseUrl,
      ),
    );

    locator.registerLazySingleton<GuideLocalDatasource>(
      () => GuideLocalDatasourceImpl(
        sharedPreferences: locator<SharedPreferences>(),
      ),
    );

    locator.registerLazySingleton<GuideRepository>(
      () => GuideRepositoryImpl(
        remoteDatasource: locator<GuideRemoteDatasource>(),
        localDatasource: locator<GuideLocalDatasource>(),
      ),
    );

    // Trips
    locator.registerLazySingleton<TripRemoteDataSource>(
      () => TripRemoteDataSourceImpl(
        client: locator<http.Client>(),
        baseUrl: AppConfig.apiBaseUrl,
      ),
    );

    locator.registerLazySingleton<TripLocalDataSource>(
      () => TripLocalDataSourceImpl(
        sharedPreferences: locator<SharedPreferences>(),
      ),
    );

    locator.registerLazySingleton<TripRepository>(
      () => TripRepositoryImpl(
        remoteDataSource: locator<TripRemoteDataSource>(),
        localDataSource: locator<TripLocalDataSource>(),
        networkInfo: locator<NetworkInfo>(),
      ),
    );

    // Providers
    locator.registerFactory(
      () => TripsProvider(repository: locator<TripRepository>()),
    );

    // Auth
    locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          remoteDataSource: locator(),
          localDataSource: locator(),
          networkInfo: locator(),
        ));

    // UseCases
    locator.registerLazySingleton(() => Login(locator<AuthRepository>()));
    locator.registerLazySingleton(() => Register(locator<AuthRepository>()));

    // ViewModels
    locator.registerFactory(() => AuthViewModel(
          login: locator<Login>(),
          register: locator<Register>(),
        ));
  }
}

// Optional: Extension method to make access more convenient
extension ServiceLocatorExtension on ServiceLocator {
  static T get<T extends Object>() => ServiceLocator.locator.get<T>();
}
