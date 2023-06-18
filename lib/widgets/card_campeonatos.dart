import 'package:flutter/material.dart';
import 'package:torneos/app/models/campeonato_model.dart';

import '../models/my_campeonato.dart';
import '../pages/initial_page.dart';
import '../utils/util_idioma.dart';
import '../utils/util_images.dart';



class CardCampeonatos extends StatelessWidget {
  final CampeonatoModel campeonato;

  CardCampeonatos({super.key, required this.campeonato});

  final _urlImages = UrlImages();
  final _utilIdioma = Idioma();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      height: 75.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(_urlImages.logoUser),
        ),
        title: Text(
          campeonato.name.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          campeonato.campeon == ''
              ? campeonato.idaVuelta
                  ? _utilIdioma.idadVuelta
                  : _utilIdioma.soloIda
              : campeonato.campeon,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          final route = MaterialPageRoute(
            builder: (context) => InitialPage(campeonato: campeonato),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}
