import 'package:flutter/material.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/pages/portrait/posiciones_page_portrait.dart';

import 'landscape/posiciones_page_landscape.dart';


class PosicionesPage extends StatelessWidget {
  final CampeonatoModel campeonato;

  PosicionesPage({super.key, required this.campeonato});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? PosicionesPagePortrait(campeonato: campeonato)
        : PosicionesPageLandscape(campeonato: campeonato);
  }
}
