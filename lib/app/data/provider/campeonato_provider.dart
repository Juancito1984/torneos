import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos/app/data/repository/campeonato_repository.dart';
import 'package:torneos/app/models/campeonato_model.dart';

import '../../../utils/colecciones_id.dart';

class CampeonatoProvider extends CampeonatoRepository {
  CampeonatoProvider._();

  static final _intance = CampeonatoProvider._();

  factory CampeonatoProvider() {
    return _intance;
  }

  final _refDb = FirebaseFirestore.instance
      .collection(coleccionBase)
      .doc(initialDoc)
      .collection(coleccionTorneos);

  @override
  Stream<List<CampeonatoModel>> readCampeonatos() {
    return _refDb.snapshots().map((event) {
      final List<CampeonatoModel> items = [];

      for (var document in event.docs) {
        items.add(CampeonatoModel.fromDocument(document));
      }

      print(items.length);
      return items;
    });
  }
}
