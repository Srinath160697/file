import 'package:flutter/material.dart';
import 'package:project/presentation/Home_Screen/home_screen.dart';
import 'package:project/presentation/authentication/logo_screen.dart';
import 'package:project/presentation/authentication/phone_login.dart';
import 'package:project/presentation/authentication/splash_screen.dart';
import 'package:project/presentation/authentication/forgot_password.dart';
import 'package:project/presentation/authentication/email_login.dart';
import 'package:project/presentation/authentication/signup.dart';
import 'package:project/presentation/todo_screens/show_listview.dart';
import 'package:project/presentation/todo_screens/todo_list.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/LoginPage': (context) => const EmailLoginPage(),
  '/showlistview': (context) => const Show_Listview(),
  '/todolist': (context) => const TodoListPage(),
  '/forgotpassword': (context) => const ForgotPasswordPage(),
  '/signup': (context) => const SignupPage(),
  // '/home': (context) => const HomePage(),
  '/logoscreen': (context) => const LogoScreen(),
  '/PhoneLogin': (context) => const PhoneLogin(),
  // '/ProfileScreen': (context) => const ProfileScreen(),
  '/HomeScreen': (context) => const HomeScreen(),
};
