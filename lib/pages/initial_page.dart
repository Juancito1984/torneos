import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/pages/posiciones_page.dart';

import '../app/theme/app_colors.dart';
import '../app/utils/idioma.dart';
import 'estadisticas_page.dart';
import 'fechas_page.dart';



//PAGINAL PRICIPAL DE LA APLICACION
class InitialPage extends StatefulWidget {
  // final MyCampeonato campeonato;
  final CampeonatoModel campeonato;

  InitialPage({super.key, required this.campeonato});

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {
  final _idioma = Idioma();
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(_idioma.titleInitialPage.toUpperCase()),
      ),
      body: _body(),
      bottomNavigationBar: _bottomNavigatosBar(),
    );
  }

  //CUERPO DE LA VISTA
  Widget _body() {
    return TabBarView(
      controller: _controller,
      children: [
        FechasPage(campeonato: widget.campeonato),
        PosicionesPage(campeonato: widget.campeonato),
        EstadisticasPage(campeonato: widget.campeonato),
      ],
    );
  }

  //BARRA INFERIOR
  Widget _bottomNavigatosBar() {
    return Container(
      height: 60.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: accentColor,
      ),
      child: TabBar(
        indicatorColor: primaryColor,
        unselectedLabelColor: Colors.grey.withOpacity(0.6),
        controller: _controller,
        tabs: [
          _itemTab(FontAwesomeIcons.calendarAlt, _idioma.fechas),
          _itemTab(FontAwesomeIcons.listOl, _idioma.posiciones),
          _itemTab(FontAwesomeIcons.userTie, _idioma.estadisticas),
        ],
      ),
    );
  }

  _itemTab(IconData icon, String title) {
    return Tab(
      icon: Icon(icon, size: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13.0),
      ),
    );
  }
}
