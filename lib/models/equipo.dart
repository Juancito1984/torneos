import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Equipo implements Comparable<Equipo> {
  final String imagen;
  final String portada;
  final String name;
  final int pGanados;
  final int pEmpatados;
  final int pPerdidos;
  final int gFavor;
  final int gContra;
  final String id;

  final double deuda;
  final double pagado;

  Equipo({
    this.imagen='',
    this.portada='',
    this.name='',
    this.pGanados=0,
    this.pEmpatados=0,
    this.pPerdidos=0,
    this.gFavor=0,
    this.gContra=0,
    this.id='',

    this.deuda = 0,
    this.pagado = 0,

  });

  List<Equipo> listaEquipos = [];

  void getEquipos(AsyncSnapshot<QuerySnapshot> snapshot) {
    listaEquipos.clear();

    for (var document in snapshot.data!.docs) {
      listaEquipos.add(Equipo(
        id: document.id,
        imagen: document['imagen'],
        portada: document['portada'],
        name: document['name'],
        pGanados: document['pGanados'],
        pEmpatados: document['pEmpatados'],
        pPerdidos: document['pPerdidos'],
        gFavor: document['gfavor'],
        gContra: document['gcontra'],

        deuda: document['deuda'].toDouble(),
        pagado: document['pagado'].toDouble(),
      ));
    }

    listaEquipos.sort();
  }

  @override
  int compareTo(equipo) {
    //Ordenar por puntos
    if ((pGanados * 3 + pEmpatados) > (equipo.pGanados * 3 + equipo.pEmpatados))
      return -1;
    if ((pGanados * 3 + pEmpatados) < (equipo.pGanados * 3 + equipo.pEmpatados))
      return 1;
    if ((pGanados * 3 + pEmpatados) ==
        (equipo.pGanados * 3 + equipo.pEmpatados)) {
      //Ordenar por goles de diferencia
      if ((gFavor - gContra) > (equipo.gFavor - equipo.gContra)) return -1;
      if ((gFavor - gContra) < (equipo.gFavor - equipo.gContra)) return 1;

      if ((gFavor - gContra) == (equipo.gFavor - equipo.gContra)) {
        if (gFavor / gContra != 0) {
          // if (!(gFavor / gContra).isFinite) {
          //Ordenar por gol averaz
          if ((gFavor / gContra) > (equipo.gFavor / equipo.gContra)) return -1;
          if ((gFavor / gContra) < (equipo.gFavor / equipo.gContra)) return 1;
        }
      }
    }
    return 0;
  }
}
