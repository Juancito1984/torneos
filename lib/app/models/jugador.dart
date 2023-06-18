import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Jugador implements Comparable<Jugador> {
  final String id;
  final dynamic parameter;

  final String name;
  final String equipo;
  final String dorsal;
  final int goles;
  final int amarillas;
  final int rojas;
  final bool ascendente;
  final String imagen;
  final String portada;
  final String fNacimiento;
  final int edad;
  final String category;

  Jugador({
    this.id = '',
    this.name = '',
    this.equipo = '',
    this.dorsal = '',
    this.goles = 0,
    this.amarillas = 0,
    this.rojas = 0,
    this.parameter,
    this.ascendente = false,
    this.imagen = '',
    this.portada = '',
    this.fNacimiento = '',
    this.edad = 0,
    this.category = '',
  });

  List<Jugador> jugadores = [];

  void getJugadoresTG({required AsyncSnapshot<
      QuerySnapshot> snapshot, required List tarjetas, required int posTarjeta,}) {
    jugadores.clear();

    for (var document in snapshot.data!.docs) {
      jugadores.add(
        Jugador(
            id: document['idJugador'],
            name: document['name'],
            equipo: document['equipo'],
            imagen: document['imagen'],
            dorsal: document['dorsal'],
            goles: document['goles'],
            amarillas: document['amarillas'],
            rojas: document['rojas'],
            parameter: document[tarjetas[posTarjeta]],
            ascendente: false),
      );
    }

    jugadores.sort();
  }

  List<Jugador> jugadoresEquipo = [];
  int _edadJugador = 0;

  void getJugadoresEquipo({required AsyncSnapshot<QuerySnapshot> snapshot}) {
    jugadoresEquipo.clear();

    snapshot.data!.docs.forEach((document) {
      // if (document['fNacimiento'] != null) {
      //   try {
      //     _edadJugador = getEdad(document['fNacimiento']);
      //
      //     if (_edadJugador != document['edad']) {
      //       document.reference.update({
      //         'edad': _edadJugador,
      //       });
      //     }
      //   } catch (error) {
      //     print('ERROR: $error');
      //   }
      // }

    jugadoresEquipo.add(
      Jugador(
          id: document['idJugador'],
          parameter: document['name'],
          ascendente: true,
          name: document['name'],
          equipo: document['equipo'],
          dorsal: document['dorsal'],
          goles: document['goles'],
          amarillas: document['amarillas'],
          rojas: document['rojas'],
          imagen: document['imagen'],
          portada: document['portada'],
          fNacimiento: document['fNacimiento'],
          edad: document['edad'],
          category: document['category']),
    );
  }

  );

  jugadoresEquipo.sort();
}

List<Jugador> jugadoresResumen = [];

void getJugadoresResumen(AsyncSnapshot<QuerySnapshot> snapshot) {
  jugadoresResumen.clear();
  snapshot.data!.docs.forEach((document) {
    _addJugador(document);
  });
}

//Comprobar desempeño del jugador
void _addJugador(DocumentSnapshot document) {
  if (document['goles'] > 0 ||
      document['amarillas'] > 0 ||
      document['rojas'] > 0) {
    jugadoresResumen.add(Jugador(
      name: document['name'],
      dorsal: document['dorsal'],
      goles: document['goles'],
      amarillas: document['amarillas'],
      rojas: document['rojas'],
      parameter: document['name'],
      ascendente: true,
    ));
  }
}

@override
compareTo(Jugador j1) {
  if (ascendente) {
    return parameter.compareTo(j1.parameter);
  } else {
    return j1.parameter.compareTo(parameter);
  }
}}