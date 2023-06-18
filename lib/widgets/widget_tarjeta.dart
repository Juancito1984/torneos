import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:torneos/app/theme/app_colors.dart';

import '../models/encuentro.dart';
import '../utils/util_images.dart';

class WidgetTarjeta extends StatelessWidget {
  final Encuentro encuentro;
  final _urlImages = UrlImages();

  WidgetTarjeta({super.key, required this.encuentro});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final design = Column(
      children: <Widget>[
        //EQUIPO A vs EQUIPO B
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //Equipo A
            _item(
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: encuentro.logoA != ''
                      ? encuentro.logoA
                      : _urlImages.noImage,

                  errorWidget: (_,__,___){
                    return Image.asset(_urlImages.noImage,width: 50);
                  },
                ),

              ),
              Text(
                encuentro.equipoA,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),

            //Resultado
            _item(
              Container(
                alignment: Alignment.center,
                width: 180.0,
                height: 45.0,
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                color: Colors.yellow,
                child: const Text(
                  'RESULTADO',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${encuentro.goolA} - ${encuentro.goolB}',
                style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
            ),

            //Equipo B
            _item(
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: encuentro.logoB != ''
                      ? encuentro.logoB
                      : _urlImages.noImage,
                  errorWidget: (_,__,___){
                    return Image.asset(_urlImages.noImage,width: 50);
                  },
                ),


              ),
              Text(
                encuentro.equipoB,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),

        //Divisor
        Divider(color: primaryColor),

        //AMONESTACIONES
        Row(
          children: <Widget>[
            _item(
              const Icon(Icons.book, color: Colors.yellow),
              Text('${encuentro.amarillasA}'),
            ),
            _item(
              const Icon(Icons.book, color: Colors.red),
              Text('${encuentro.rojasA}'),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                encuentro.estado == 'Hora' ? 'POR JUGAR' : encuentro.estado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            _item(
              const Icon(Icons.book, color: Colors.yellow),
              Text('${encuentro.amarillasB}'),
            ),
            _item(
              const Icon(Icons.book, color: Colors.red),
              Text('${encuentro.rojasB}'),
            ),
          ],
        ),
      ],
    );
    return SingleChildScrollView(
      child: design,
    );
  }

  Widget _item(Widget widget, Widget value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            widget,
            const SizedBox(height: 8.0),
            value,
          ],
        ),
      ),
    );
  }
}
