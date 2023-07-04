
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/splash_module/splash_controller.dart';
import 'package:torneos/app/theme/app_colors.dart';
import 'package:torneos/app/utils/util_images.dart';


class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: accentColor,
        body: FutureBuilder(
          future: controller.verifyUser(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(UrlImages().initialLogo),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
