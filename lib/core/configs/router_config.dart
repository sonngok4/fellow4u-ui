// lib/core/configs/router_config.dart
import 'package:go_router/go_router.dart';

import '../../features/agency_management/presentation/pages/agency_dashboard_page.dart';
import '../../features/auth/presentation/common/pages/login_page.dart';
import '../../features/auth/presentation/common/pages/register_page.dart';
import '../../features/auth/presentation/common/pages/splash_page.dart';
import '../../features/auth/presentation/common/pages/welcome_page.dart';
import '../../features/auth/presentation/guide/pages/guide_dashboard_page.dart';
import '../../features/guide_management/domain/repositories/guide_repository.dart';
import '../../features/traveler_management/presentation/pages/traveler_home_page.dart';
import '../../features/trips/domain/repositories/trip_repository.dart';
import '../services/service_locator.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    // Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    // Agency Routes
    GoRoute(
      path: '/agency/dashboard',
      builder: (context, state) => const AgencyDashboardPage(),
    ),
    // Guide Routes
    GoRoute(
      path: '/guide/dashboard',
      builder: (context, state) => const GuideDashboardPage(),
    ),
    // Traveler Routes
    GoRoute(
      path: '/traveler/home',
      builder: (context, state) => TravelerHomePage(
        tripRepository: ServiceLocator.locator<TripRepository>(),
        guideRepository: ServiceLocator.locator<GuideRepository>(),
      ),
    ),
  ],
);
