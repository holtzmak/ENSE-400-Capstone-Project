import 'package:flutter/material.dart';

/*
    The padding property can be added to style.dart,
    but doing so would be an overkill.
    Source: https://stackoverflow.com/questions/44053363/flutter-padding-for-all-widgets
  */
const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 23.0;

const MainAppColor = Color(0xff66bb6a);

const BottomBorderStyle = BorderSide(
  // Add more properties if needed
  color: Color(0xFFBDBDBD),
);

const GradientColors = LinearGradient(
  // Add more properties if needed
  colors: [Colors.green, Colors.greenAccent],
);

const TitleTextStyle = TextStyle(
  fontSize: LargeTextSize,
  color: Color(0xFF212121),
);

const BodyTextStyle = TextStyle(
  fontSize: SmallTextSize,
  color: Color(0xFF212121),
  letterSpacing: 1.5,
);

const DefaultRaisedButtonStyle = ButtonThemeData(
  buttonColor: Colors.green,
);

const OverlayColor = Color.fromRGBO(0, 0, 0, 0.5);

const CircleAvatarBackgroundColor = Color(0xffFDCF09);
