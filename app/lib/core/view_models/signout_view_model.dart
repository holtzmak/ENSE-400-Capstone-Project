import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/welcome/welcome.dart';

class SignOutViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signOut() async {
    // TODO: Should handle exception error
    try {
      _navigationService.navigateTo(WelcomeScreen.route);
      await _authenticationService.signOut();

      print('user successfully signed out');
    } catch (e) {
      print(e.message);
    }
  }
}
