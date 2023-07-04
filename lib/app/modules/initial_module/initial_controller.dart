import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torneos/app/models/campeonato_model.dart';

class InitialController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  CampeonatoModel campeonato = CampeonatoModel();

  @override
  void onInit() {
    campeonato = Get.arguments;
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}
