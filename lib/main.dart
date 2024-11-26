// lib/main.dart
import 'package:fellow4u_ui/core/configs/app_config.dart';
import 'package:fellow4u_ui/core/configs/injection_container.dart';
import 'package:fellow4u_ui/core/configs/router_config.dart';
import 'package:fellow4u_ui/core/configs/theme_config.dart';
import 'package:fellow4u_ui/features/guide_management/data/datasources/guide_local_datasource.dart';
import 'package:fellow4u_ui/features/guide_management/data/datasources/guide_remote_datasource.dart';
import 'package:fellow4u_ui/features/guide_management/domain/repositories/guide_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'core/localization/app_localizations.dart';
import 'core/network/network_info.dart';
import 'core/services/service_locator.dart';
import 'features/auth/presentation/common/viewmodels/auth_viewmodel.dart';
import 'features/guide_management/data/repositories/guide_repository_impl.dart';
import 'features/guide_management/presentation/providers/guide_provider.dart';
import 'features/trips/data/datasources/trip_local_datasource.dart';
import 'features/trips/data/datasources/trip_remote_datasource.dart';
import 'features/trips/data/repositories/trip_repository_impl.dart';
import 'features/trips/domain/repositories/trip_repository.dart';
import 'features/trips/presentation/provider/providers/provider_trips_provider.dart'; 

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setup();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthViewModel>()),
        // Add other providers
        // Network Info Provider
        Provider<NetworkInfo>(
          create: (_) => NetworkInfoImpl(
            InternetConnectionChecker(),
          ),
        ),

        // Remote Data Source Provider
        Provider<TripRemoteDataSource>(
          create: (_) => TripRemoteDataSourceImpl(
            client: http.Client(),
            baseUrl:
                dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api/v1',
          ),
        ),
        // Repository Provider
        Provider<TripRepository>(
          create: (context) => TripRepositoryImpl(
            remoteDataSource: context.read<TripRemoteDataSource>(),
            localDataSource: context.read<TripLocalDataSource>(),
            networkInfo: context.read<NetworkInfo>(),
          ),
        ),
        // Trips Provider
        ChangeNotifierProxyProvider<TripRepository, TripsProvider>(
          create: (context) => TripsProvider(
            repository: context.read<TripRepository>(),
          ),
          update: (context, repository, previous) =>
              TripsProvider(repository: repository),
        ),

        // Remote Data Source Provider
        Provider<GuideRemoteDatasource>(
          create: (_) => GuideRemoteDatasourceImpl(
            client: http.Client(),
            baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api',
          ),
        ),
        // Repository Provider
        Provider<GuideRepository>(
          create: (context) => GuideRepositoryImpl(
            remoteDatasource: context.read<GuideRemoteDatasource>(),
            localDatasource: context.read<GuideLocalDatasource>(),
          ),
        ),
        // Guide Provider
        ChangeNotifierProxyProvider<GuideRepository, GuideProvider>(
          create: (context) => GuideProvider(
            repository: context.read<GuideRepository>(),
          ),
          update: (context, repository, previous) =>
              GuideProvider(repository: repository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppConfig.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: router,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppConfig.supportedLocales,
        locale: AppConfig.defaultLocale, // Set default locale
      ),
    );
  }
}
