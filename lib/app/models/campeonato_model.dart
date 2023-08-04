import 'package:cloud_firestore/cloud_firestore.dart';

class CampeonatoModel {
  final String name;
  final int index;
  final int cantEquipos;
  final int cantFechas;
  final bool idaVuelta;
  final String campeon;
  final DocumentReference? reference;

  final int cAmarillas;
  final int cRojas;
  final int cCancha;
  final int pGanador;
  final int pEmpate;

  CampeonatoModel({
    this.name = '',
    this.index = 0,
    this.cantEquipos = 0,
    this.cantFechas = 0,
    this.idaVuelta = false,
    this.campeon = '',
    this.reference,

    this.cAmarillas = 0,
    this.cRojas = 0,
    this.cCancha = 0,
    this.pGanador = 0,
    this.pEmpate = 0,

  });

  factory CampeonatoModel.fromDocument(DocumentSnapshot document) {
    return CampeonatoModel(
      name: document['name'],
      index: document['index'],
      cantEquipos: document['cantEquipos'],
      cantFechas: document['cantFechas'],
      idaVuelta: document['idaVuelta'],
      campeon: document['campeon'],
      reference: document.reference,

      cAmarillas: document['cAmarillas'],
      cRojas: document['cRojas'],
      cCancha: document['cCancha'],
      pGanador: document['pGanador'],
      pEmpate: document['pEmpate'],

    );
  }
}
