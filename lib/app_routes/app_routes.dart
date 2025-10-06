// lib/app_routes/app_routes.dart
import 'package:go_router/go_router.dart';

import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../welcome/welcom_screen/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';

  static final GoRouter router = GoRouter(
    initialLocation: welcome,
    routes: <RouteBase>[
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}