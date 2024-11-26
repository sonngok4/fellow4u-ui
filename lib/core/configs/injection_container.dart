// lib/core/configs/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fellow4u_ui/core/configs/app_config.dart';
import 'package:dio/dio.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usescases/login.dart';
import '../../features/auth/domain/usescases/register.dart';
import '../../features/auth/presentation/common/viewmodels/auth_viewmodel.dart';
// import '../analytics/analytics_service.dart';
import '../../features/trips/data/datasources/trip_remote_datasource.dart';
import '../../features/trips/data/repositories/trip_repository_impl.dart';
import '../../features/trips/domain/repositories/trip_repository.dart';
import '../../features/trips/presentation/provider/providers/provider_trips_provider.dart';
import '../network/network_info.dart';
import '../services/navigation_service.dart';
// import '../services/push_notification_service.dart';
import '../storage/local_storage.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


  // External
  sl.registerLazySingleton(() => Dio(BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: {'Accept': 'application/json'},
      )));

  // Services
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(sl()));
  sl.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
  // sl.registerLazySingleton<AnalyticsService>(() => FirebaseAnalyticsImpl());
  // sl.registerLazySingleton<PushNotificationService>(
  //     () => FirebaseMessagingImpl());


  // Providers
  sl.registerFactory(
    () => TripsProvider(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // DataSources
  sl.registerLazySingleton<TripRemoteDataSource>(
    () => TripRemoteDataSourceImpl(
      client: sl(),
      baseUrl: AppConfig.apiBaseUrl,
    ),
  );
  // UseCases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  // ViewModels
  sl.registerFactory(() => AuthViewModel(
        login: sl<Login>(),
        register: sl<Register>(),
      ));
}


