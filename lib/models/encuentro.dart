import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Encuentro implements Comparable<Encuentro> {
  final String id;
  final String equipoA;
  final String equipoB;
  final int amarillasA;
  final int amarillasB;
  final int rojasA;
  final int rojasB;
  final String hora;
  final int goolA;
  final int goolB;
  final String logoA;
  final String logoB;
  final String estado;
  final int index;
  final String comentario;
  final DocumentReference? reference;

  Encuentro({
    this.id = '',
    this.equipoA = '',
    this.equipoB = '',
    this.amarillasA = 0,
    this.amarillasB = 0,
    this.rojasA = 0,
    this.rojasB = 0,
    this.hora = '',
    this.goolA = 0,
    this.goolB = 0,
    this.logoA = '',
    this.logoB = '',
    this.estado = '',
    this.index = 0,
    this.comentario = '',
    this.reference,
  });

  List<Encuentro> encuentros = [];

  void getEncuentros(AsyncSnapshot<QuerySnapshot> snapshot) {
    encuentros.clear();

    snapshot.data!.docs.forEach((document) {
      encuentros.add(Encuentro(
        reference: document.reference,
        equipoA: document['equipoA'],
        equipoB: document['equipoB'],
        logoA: document['logoA'],
        logoB: document['logoB'],
        goolA: document['goolA'],
        goolB: document['goolB'],
        amarillasA: document['amarillasA'],
        amarillasB: document['amarillasB'],
        rojasA: document['rojasA'],
        rojasB: document['rojasB'],
        hora: document['hora'],
        estado: document['estado'],
        comentario: document['comentario'],
        index: document['index'],
      ));
    });

    encuentros.sort();
  }

  @override
  int compareTo(Encuentro e1) {
//    if (index > e1.index) return 1;
//    if (index < e1.index) return -1;
//    return 0;
    return index.compareTo(e1.index);
  }
}
