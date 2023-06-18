import 'package:cloud_firestore/cloud_firestore.dart';

class CampeonatoModel {
  final String name;
  final int index;
  final int cantEquipos;
  final int cantFechas;
  final bool idaVuelta;
  final String campeon;
  final DocumentReference? reference;

  CampeonatoModel({
    this.name = '',
    this.index = 0,
    this.cantEquipos = 0,
    this.cantFechas = 0,
    this.idaVuelta = false,
    this.campeon = '',
    this.reference,
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
    );
  }
}
