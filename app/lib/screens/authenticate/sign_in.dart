import 'package:app/common/enums/app_state.dart';
import 'package:app/navigation/side_bar/sidebar.dart';
import 'package:app/providers/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthenticationProvider>(
          builder: (context, model, child) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TEST',
                  key: Key('test'),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  controller: emailController,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                // TODO: Add logic that will disable the widget when we're awaiting for response
                model.viewState == ViewState.Busy
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        onPressed: () {
                          model.signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        child: Text('Sign In'),
                        color: Colors.green,
                      ),
                SizedBox(
                  height: 100.0,
                ),
                RaisedButton(
                  child: Text('Go back to welcome screen'),
                  color: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              // TODO: Account creation
            ),
          ),
        ),
      ),
    );
  }
}
