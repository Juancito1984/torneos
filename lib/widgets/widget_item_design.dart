import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:torneos/app/theme/app_colors.dart';

import '../utils/util_images.dart';


class ItemDesign extends StatelessWidget {
  final BuildContext context;
  final String imagen;
  final Widget title;
  final int edad;
  final String subtitle1;
  final String subtitle2;
  final Widget treailing;
  final Function()? onTap;

  ItemDesign({

    required this.context,
    required this.imagen,
    required this.title,
    required this.treailing,
    this.subtitle1='',
    this.edad=0,
    this.subtitle2='',
    this.onTap,
  }) ;

  final _urlImages = UrlImages();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Imagen
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: imagen != ''
                      ? FadeInImage(
                          height: 40.0,
                          width: 40.0,
                          placeholder: AssetImage(_urlImages.noImage),
                          image: CachedNetworkImageProvider(imagen),
                        )
                      : Image(
                          image: AssetImage(_urlImages.noImage),
                          height: 40.0,
                          width: 40.0,
                        ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Nombre
                      title,

                      subtitle1 != null ? Text(subtitle1) : Container(),
                      //Numero
                      subtitle2 != null ? Text(subtitle2) : Container(),
                    ],
                  ),
                ),
                treailing
              ],
            ),
          ),
          Divider(height: 0.0, color: primaryColor)
        ],
      ),
    );
  }
}
