import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:package_info/package_info.dart';
import 'package:torneos/app/data/provider/campeonato_provider.dart';
import 'package:torneos/app/data/provider/login_provider.dart';
import 'package:torneos/app/data/provider/matrix_db_provider.dart';
import 'package:torneos/app/models/campeonato_model.dart';

import '../../utils/strings.dart';
import '../../utils/util_images.dart';
import '../../models/initial_doc.dart';
import '../../theme/app_colors.dart';

class HomeController extends GetxController
    with StateMixin<List<CampeonatoModel>> {
  final loginProvider = LoginProvider();
  final campeonatoProvider = CampeonatoProvider();
  final initialDoc = InitialDoc().obs;

  final urlImages = UrlImages();

  // final colors = UtilColors();

  final User? user = FirebaseAuth.instance.currentUser;

  // final PackageInfo infoApps = PackageInfo(
  PackageInfo infoApps = PackageInfo(
    version: '',
    appName: '',
    packageName: '',
    buildNumber: '',
  );

  //INFORMACION SORE LA APLICACION
  Future<Null> _initInfoApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    infoApps = packageInfo;
  }

  //Programamos el boton atras
  Future<bool> buildAtras() async {
    await Get.dialog(
      AlertDialog(
        title: Text(salirDeApp),
        actions: <Widget>[
          TextButton(
            child: Text(cancelar),
            onPressed: () => Get.back(canPop: false),
          ),
          MaterialButton(
            color: primaryColor,
            textColor: Colors.white,
            onPressed: () => SystemNavigator.pop(),
            child: Text(aceptar),
          ),
        ],
      ),
    );

    return false;
  }

  //INFORMACION ACERCA DE LA APLICACION
  void acercaDe() {
    Get.dialog(AlertDialog(
      elevation: 0.0,
      backgroundColor: primaryColor.withOpacity(0.8),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Nombre app
            Text(
              infoApps.appName.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            ),

            const SizedBox(height: 10.0),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(urlImages.initialLogo),
            ),
            const SizedBox(height: 10.0),

            //Version app
            Text(
              'Version: ${infoApps.version}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              developers,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 0.0,
          color: buttonColor.withOpacity(0.7),
          textColor: Colors.white,
          onPressed: () => Get.back(),
          child: Text(aceptar),
        )
      ],
    ));
  }

  _leerDatoDeCampeonato() {
    change(null, status: RxStatus.loading());
    campeonatoProvider.readCampeonatos().listen((event) {
      if (event.isNotEmpty) {
        change(event, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }).onError((error) {
      return change(null, status: RxStatus.error(error));
    });
  }

  @override
  void onInit() {
    _initInfoApp();
    _leerDatoDeCampeonato();
    initialDoc.bindStream(MatrixDbProvider().readDoc());
    super.onInit();
  }
}
