import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/app/modules/home_module/home_controller.dart';

import '../../../../pages/initial_page.dart';


class ItemCampeonato extends GetView<HomeController> {
  final CampeonatoModel campeonato;
  const ItemCampeonato({super.key, required this.campeonato});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      height: 75.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.85),
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
              ? controller.idioma.idadVuelta
              : controller.idioma.soloIda
              : campeonato.campeon,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          final route = MaterialPageRoute(
            builder: (context) => InitialPage(campeonato: campeonato),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}
