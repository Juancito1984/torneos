import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fecha implements Comparable<Fecha> {
  final String name;
  final String dia;
  final String fecha;
  final String idaVuelta;
  final bool jugado;
  final bool esFinal;
  final int index;
  final DocumentReference? reference;

  Fecha({
    this.name='',
    this.dia='',
    this.fecha='',
    this.idaVuelta='',
    this.jugado=false,
    this.esFinal=false,
    this.index=0,
    this.reference,
  });

  List<Fecha> fechas = [];

  void getFechas(AsyncSnapshot<QuerySnapshot> snapshot) {
    fechas.clear();
    for (var document in snapshot.data!.docs) {
      fechas.add(Fecha(
        name: document['name'],
        dia: document['dia'],
        fecha: document['fecha'],
        idaVuelta: document['idaVuelta'],
        index: document['index'],
        jugado: document['jugado'],
        esFinal: document['esFinal'],
        reference: document.reference,
      ));
    }
    fechas.sort();
  }

  @override
  int compareTo(Fecha f1) {
//    if(index > f1.index) return 1;
//    if(index < f1.index) return -1;
//    return 0;
    return index.compareTo(f1.index);
  }
}
