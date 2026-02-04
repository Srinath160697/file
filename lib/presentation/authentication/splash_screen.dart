import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/core/constant/Color/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      Navigator.pushNamed(context, '/logoscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 140;
    return Scaffold(
      // no app bar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: const Center(
          child: ClipOval(
            child: SizedBox(
              width: imageSize,
              height: imageSize,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
