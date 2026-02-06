import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/repository/location_repo_impl.dart';
import 'package:project/presentation/bloc/location_bloc.dart';
import 'package:provider/provider.dart';
import 'package:project/core/constant/Routers/router.dart';
import 'package:project/presentation/bloc/background_location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // ✅ create repo
  final locationRepo = LocationRepoImpl();

  // ✅ connect repo to background service
  BackgroundLocationService.init(locationRepo);

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => LocationBloc(locationRepo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GuardianRoute',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: appRoutes,
        );
      },
    );
  }
}
