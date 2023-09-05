import 'package:coding_test/Screens/UserListScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          duration: 1500,
          splash: SvgPicture.asset(
            'assets/logo/motesplatsen_logo.svg',
            fit: BoxFit.contain, // Adjust the fit as needed
          ),
          nextScreen: const UserListScreen(),
          splashTransition: SplashTransition.fadeTransition,
        ));
  }
}
