import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/ui/views/account/account_editing_screen.dart';
import 'package:app/ui/views/account/account_screen.dart';
import 'package:app/ui/views/active/active_screen.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:app/ui/views/sign_in_screen.dart';
import 'package:app/ui/views/sign_up_screen.dart';
import 'package:app/ui/views/welcome_screen.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  static final _authenticationService = locator<AuthenticationService>();

  static bool isLoggedIn() => _authenticationService.currentUser.isPresent();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (BuildContext context) {
        switch (settings.name) {
          // Welcome screens, available anytime
          case WelcomeScreen.route:
            return WelcomeScreen();
          case SignInScreen.route:
            return SignInScreen();
          case SignUpScreen.route:
            return SignUpScreen();
          // Main screens, only available if logged in
          case HomeScreen.route:
            return isLoggedIn()
                ? HomeScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case AccountScreen.route:
            return isLoggedIn()
                ? AccountScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case AccountEditingScreen.route:
            return isLoggedIn()
                ? AccountEditingScreen(account: settings.arguments)
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case ActiveScreen.route:
            return isLoggedIn()
                ? ActiveScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case HistoryScreen.route:
            return isLoggedIn()
                ? HistoryScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case ATRDisplayScreen.route:
            return isLoggedIn()
                ? ATRDisplayScreen(atr: settings.arguments)
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case ATREditingScreen.route:
            return isLoggedIn()
                ? ATREditingScreen(atr: settings.arguments)
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          // Secondary screens, only available if logged in
          case ImageScreen.route:
            return isLoggedIn()
                ? ImageScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case PDFScreen.route:
            return isLoggedIn()
                ? PDFScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
