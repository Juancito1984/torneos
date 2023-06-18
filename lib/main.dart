import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/login_module/login_bindings.dart';
import 'package:torneos/app/modules/login_module/login_page.dart';
import 'package:torneos/app/modules/splash_module/splash_bindings.dart';
import 'package:torneos/app/modules/splash_module/splash_page.dart';
import 'package:torneos/app/routes/app_pages.dart';
import 'package:torneos/app/theme/app_colors.dart';
import 'package:torneos/pages/my_home_page.dart';
import 'package:torneos/pages/my_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Torneo app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:accentColor),
        // useMaterial3: true,
      ),
      initialBinding: SplashBinding(),
      home: const SplashPage(),
      getPages: AppPages.pages,
    );

/*
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginPage(),
    );

    */
  }
}
