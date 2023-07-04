import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/app/modules/home_module/home_controller.dart';
import 'package:torneos/app/routes/app_pages.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/strings.dart';

class ItemCampeonato extends GetView<HomeController> {
  final CampeonatoModel campeonato;

  const ItemCampeonato({super.key, required this.campeonato});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      height: 75.0,
      width: Get.size.width,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(controller.urlImages.initialLogo),
        ),
        title: Text(
          campeonato.name.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          campeonato.campeon == ''
              ? campeonato.idaVuelta
                  ? idadVuelta
                  : soloIda
              : campeonato.campeon,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          Get.toNamed(Routes.INITIAL, arguments: campeonato);

        },
      ),
    );
  }
}
