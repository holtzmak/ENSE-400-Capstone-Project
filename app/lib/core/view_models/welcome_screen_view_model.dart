import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:app/ui/views/sign_in_screen.dart';
import 'package:app/ui/views/sign_up_screen.dart';

class WelcomeScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void skipToHomeScreenIfLoggedIn() {
    if (_authenticationService.currentUser.isPresent()) _navigateToHomeScreen();
  }

  void navigateToSignInScreen() =>
      _navigationService.navigateTo(SignInScreen.route);

  void navigateToSignUpScreen() =>
      _navigationService.navigateTo(SignUpScreen.route);

  void _navigateToHomeScreen() =>
      _navigationService.navigateTo(HomeScreen.route);
}
