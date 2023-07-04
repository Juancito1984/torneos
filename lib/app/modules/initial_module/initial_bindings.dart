import 'package:torneos/app/modules/initial_module/initial_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialController());
  }
}