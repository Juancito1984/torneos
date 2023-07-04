import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/initial_module/initial_controller.dart';
import 'package:torneos/app/modules/initial_module/widgets/option_navigator_bar.dart';

import '../../../pages/estadisticas_page.dart';
import '../../../pages/fechas_page.dart';
import '../../../pages/posiciones_page.dart';
import '../../utils/strings.dart';

class InitialPage extends GetView<InitialController> {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(titleInitialPage.toUpperCase()),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          FechasPage(campeonato: controller.campeonato),
          PosicionesPage(campeonato: controller.campeonato),
          EstadisticasPage(campeonato: controller.campeonato),
        ],
      ),

      bottomNavigationBar: const OptionNavigatorBar(),
    );
  }
}
