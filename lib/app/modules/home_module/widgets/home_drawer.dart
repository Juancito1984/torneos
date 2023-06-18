import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/home_module/home_controller.dart';
import 'package:torneos/app/routes/app_pages.dart';

class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                controller.user!.photoURL == null
                    ? controller.urlImages!.logoUser
                    : controller.user!.photoURL!,
              ),
            ),
            // accountName: Text(_idioma.user),
            // accountEmail: Text(_idioma.email),
            accountName: controller.user!.displayName == null
                ? Text(controller.idioma.user)
                : Text(controller.user!.displayName!),
            accountEmail: controller.user!.email == null
                ? Text(controller.idioma.email)
                : Text(controller.user!.email!),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Acerca de...
                  ListTile(
                    leading: Icon(FontAwesomeIcons.infoCircle,
                        size: 20.0, color: controller.colors.primaryColor),
                    title: Text(controller.idioma.titleAcerca),
                    subtitle: Text(controller.idioma.despAcerca),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: controller.colors.accentColor),
                    onTap: () {
                      Navigator.pop(context);
                      controller.acercaDe();
                    },
                  ),
                  //Cerrar sesion
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorOpen,
                        size: 20.0, color: controller.colors.primaryColor),
                    title: Text(controller.idioma.cerrarSesion),
                    subtitle: Text(controller.idioma.despcerrarSesion),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: controller.colors.accentColor),
                    onTap: () {
                      controller.loginProvider.logout().then(
                            (value) => Get.offNamed(Routes.LOGIN),
                          );
                      Navigator.pop(context);
                    },
                  ),

                  //Salir de la aplicacion
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorClosed,
                        size: 20.0, color: controller.colors.primaryColor),
                    title: Text(controller.idioma.titleSalir),
                    subtitle: Text(controller.idioma.despSalir),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: controller.colors.accentColor),
                    onTap: () {
                      Navigator.pop(context);
                      controller.buildAtras();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
