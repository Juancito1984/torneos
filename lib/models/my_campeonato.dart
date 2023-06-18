
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCampeonato implements Comparable<MyCampeonato> {
  final String name;
  final int index;
  final int cantEquipos;
  final int cantFechas;
  final bool idaVuelta;
  final String campeon;
  final DocumentReference? reference;

  MyCampeonato({
    this.name='',
    this.index=0,
    this.cantEquipos=0,
    this.cantFechas=0,
    this.idaVuelta=false,
    this.campeon='',
    this.reference,
  });

  //Lista de campeonatos
  List<MyCampeonato> campeonatos = [];

  void getCampeonatos(AsyncSnapshot<QuerySnapshot> snapshot) {

    campeonatos.clear();

    snapshot.data!.docs.forEach((element) {
      // print(element['']);
    });

    snapshot.data!.docs.forEach((camp) {
      campeonatos.add(MyCampeonato(
        name: camp['name'],
        index: camp['index'],
        cantEquipos: camp['cantEquipos'],
        cantFechas: camp['cantFechas'],
        idaVuelta: camp['idaVuelta'],
        campeon: camp['campeon'],
        reference: camp.reference,
      ));
    });

    campeonatos.sort();
  }

  @override
  int compareTo(MyCampeonato c1) {
    return c1.index.compareTo(index);
   // return index.compareTo(c1.index);
  }
}
