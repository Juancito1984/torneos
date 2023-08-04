import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/home_module/home_controller.dart';
import 'package:torneos/app/modules/home_module/widgets/home_drawer.dart';
import 'package:torneos/app/modules/home_module/widgets/list_campeonatos.dart';
import 'package:torneos/app/widgets/no_data.dart';
import 'package:torneos/widgets/widget_loading.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.initialDoc.value.isActive
          ? WillPopScope(
              onWillPop: () async {
                final popupOut = await controller.buildAtras();
                return popupOut!;
              },
              child: Scaffold(
                drawer: const HomeDrawer(),
                appBar: AppBar(
                    title: Text(controller.idioma.titleHomePage.toUpperCase())),
                body: controller.obx(
                  (state) => ListCampeonatos(campeonatos: state!),
                  onLoading: WidgetLoading(),
                  onEmpty: NoData(controller.idioma.noData),
                  onError: (error) => NoData(error!),
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(controller.urlImages.imageNoData, width: 160),
                    NoData(controller.idioma.baseDesactivada)
                  ],
                ),
              ),
            ),
    );
  }
}
