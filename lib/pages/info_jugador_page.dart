import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../app/models/jugador.dart';
import '../app/utils/strings.dart';
import '../app/utils/util_images.dart';

class InfoJugador extends StatelessWidget {
  final Jugador jugador;

  InfoJugador({super.key, required this.jugador});

  final _urlImages = UrlImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(infoJugador)),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xffBE9E34).withOpacity(0.64),
                  const Color(0xff216971),
                ],
              ),
            ),
          ),
          _body(context)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Nombre del jugador
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              jugador.name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 5.0),
          //Imagen jugador
          ClipRRect(
            borderRadius: BorderRadius.circular(140.0),
            child: jugador.imagen != ''
                ? FadeInImage(
                    placeholder: AssetImage(_urlImages.noImage),
                    image: CachedNetworkImageProvider(jugador.imagen),
                    height: 250.0,
                    width: 250.0,
                  )
                : Image(
                    height: 250.0,
                    width: 250.0,
                    image: AssetImage(_urlImages.noImage),
                  ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Informacion del jugador
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _item1('Equipo:', jugador.equipo),
                  _item1('Fecha de Nacimiento:', jugador.fNacimiento),
                  _item1('Edad:', '${jugador.edad} años'),
                  _item1('Numero de casimeta:', jugador.dorsal),
                ],
              ),

              //Desempeño deportivo del jugador
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _item2(jugador.goles.toString(), 'Goles', Colors.green),
                  _item2(
                      jugador.amarillas.toString(), 'Amarillas', Colors.yellow),
                  _item2(jugador.rojas.toString(), 'Rojas', Colors.red),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _item1(String title, String details, [double bottom = 5.0]) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          ),
          Text(
            details,
            style: const TextStyle(color: Colors.black87, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _item2(String desemp, String title, Color color) {
    return Column(
      children: <Widget>[
        //CIRCULO
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100.0),
          ),
          alignment: Alignment.center,
          height: 50.0,
          width: 50.0,
          child: Text(
            desemp,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25.0),
          ),
        ),
        const SizedBox(height: 5.0),

        //NOMBRE
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
