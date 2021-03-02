import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;

  WelcomeScreen({Key key, this.title}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<WelcomeScreenViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!'),
              RaisedButton(
                onPressed: model.navigateToSignInScreen,
                child: Text('Sign In'),
              ),
              RaisedButton(
                onPressed: model.navigateToSignUpScreen,
                child: Text('Register'),
              ),
              // TODO: Remove eventually, useful for testing now
              RaisedButton(
                onPressed: model.navigateToHomeScreen,
                child: Text('Skip sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
