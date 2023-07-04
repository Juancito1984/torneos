import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/login_module/login_controller.dart';
import 'package:torneos/app/modules/login_module/widgets/login_button.dart';
import 'package:torneos/app/modules/login_module/widgets/text_helper.dart';

import '../../routes/app_pages.dart';
import '../../utils/strings.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Fondo de pantalla
          SizedBox(
            height: Get.size.height,
            child: Image(
              image: AssetImage(controller.urlImages.fondoLogin),
              fit: BoxFit.cover,
            ),
          ),

          //Efecto para el fondo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff216971),
                  const Color(0xffBE9E34).withOpacity(0.64),
                ],
              ),
            ),
          ),

          //Contenido
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                //Texto superior
                TextHelper(title: nota, size: 16),

                //Logo de App
                Image.asset(
                  controller.urlImages.initialLogo,
                  height: 250.0,
                ),
                const SizedBox(height: 80.0),

                //Boton de inicio de sesion
                LoginButtom(
                  icon: const Icon(FontAwesomeIcons.google),
                  label: google,
                  onPressed: () {
                    controller.loginProvider.loginGoogle().then(
                          (value) => Get.offNamed(Routes.HOME),
                        );
                  },
                ),

                //Ayuda boton de inicio
                TextHelper(title: iniciaConGoogle, size: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
