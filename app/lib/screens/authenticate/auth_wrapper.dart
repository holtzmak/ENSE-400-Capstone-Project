import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticateWrapper extends StatelessWidget {
  const AuthenticateWrapper({Key key}) : super(key: key);
  static const route = '/auth_wrapper';
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser == null) {
      return SignInScreen();
    } else {
      return HomeRootScreen();
    }
  }
}
