//final imagesUtil = UrlImages();

class UrlImages {
  UrlImages._internal();

  static final _instancia = UrlImages._internal();

  factory UrlImages() {
    return _instancia;
  }

  final String loading = 'assets/images/loading.gif';
  final String logoUser = 'assets/images/logo_user.png';
  final String noImage = 'assets/images/no-image-icon.png';
  final String noUser = 'assets/images/noUser.png';
  final String fondoLogin = 'assets/images/fondoLogin.png';
  final String iconGoogle='assets/icons/icon_google.png';

  //PNG
  final String initialLogo='assets/png/initialLogo.png';
  final String imageNoData='assets/png/noData.png';
}