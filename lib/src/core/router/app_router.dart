import 'package:flutter/material.dart';
import 'package:task/src/features/auth/screens/create_user_screen.dart';
import 'package:task/src/features/auth/screens/otp_screen.dart';
import 'package:task/src/features/auth/screens/splash_screen.dart';
import 'package:task/src/features/home/screens/home_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import 'app_router_names.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRouterNames.rLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRouterNames.rOTP:
        return MaterialPageRoute(
          builder: (_) => const OTPScreen(),
        );
      case AppRouterNames.rCreateUser:
        return MaterialPageRoute(
          builder: (_) => const CreateUserScreen(),
        );
      case AppRouterNames.rHome:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
