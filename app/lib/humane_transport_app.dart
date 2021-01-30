import 'package:app/ui/common/style/style.dart';
import 'package:app/ui/routes/main_navigator/app_route.dart';
import 'package:flutter/material.dart';
import 'core/services/navigation/nav_service.dart';
import 'core/services/service_locator.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: MainAppColor),
        textTheme: TextTheme(
          headline5: TitleTextStyle,
          bodyText1: BodyTextStyle,
        ),
        iconTheme: IconThemeData(
          color: MainAppColor,
        ),
        buttonTheme: DefaultRaisedButtonStyle,
      ),
    );
  }
}
