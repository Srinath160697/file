import 'package:flutter/material.dart';
import 'package:project/presentation/screens/authentication/email_login.dart';
import 'package:project/presentation/screens/authentication/forgot_password.dart';
import 'package:project/presentation/screens/authentication/logo_screen.dart';
import 'package:project/presentation/screens/authentication/phone_login.dart';
import 'package:project/presentation/screens/authentication/signup.dart';
import 'package:project/presentation/screens/authentication/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/LoginPage': (context) => const EmailLoginPage(),
  '/forgotpassword': (context) => const ForgotPasswordPage(),
  '/signup': (context) => const SignupPage(),
  '/logoscreen': (context) => const LogoScreen(),
  '/PhoneLogin': (context) => const PhoneLogin(),
  // '/ProfileScreen': (context) => const ProfileScreen(),
  // '/home': (context) => const HomePage(),
};
