
import 'package:get/get.dart';
import 'package:torneos/app/data/provider/login_provider.dart';

import '../../utils/idioma.dart';
import '../../utils/util_images.dart';

class LoginController extends GetxController {
  final urlImages = UrlImages();
  final idioma = Idioma();
  final LoginProvider loginProvider = LoginProvider();
}
