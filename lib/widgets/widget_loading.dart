import 'package:flutter/material.dart';

import '../utils/util_idioma.dart';
import '../utils/util_images.dart';


class WidgetLoading extends StatelessWidget {
  final _urlImages = UrlImages();
  final _idioma = Idioma();

  WidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(image: AssetImage(_urlImages.loading), width: 80.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            _idioma.cargando,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    ));
  }
}
