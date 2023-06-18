import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:torneos/app/routes/app_pages.dart';

class SplashController extends GetxController {
  verifyUser()  async{
    await FirebaseAuth.instance.currentUser != null
        ? Get.offNamed(Routes.HOME)
        : Get.offNamed(Routes.LOGIN);
  }
}
