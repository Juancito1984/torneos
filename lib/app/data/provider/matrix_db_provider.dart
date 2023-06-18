import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/colecciones_id.dart';
import '../../models/initial_doc.dart';
import '../repository/matrix_db_repòsitory.dart';

class MatrixDbProvider extends MatrixDbRepository {
  MatrixDbProvider._();
  static final _intance = MatrixDbProvider._();
  factory MatrixDbProvider(){
    return _intance;
  }


  final _refDb = FirebaseFirestore.instance
      .collection(coleccionBase)
      .doc(initialDoc);

  @override
  createDb() async {


    /*
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(coleccionTorneos)
        .doc(initialDoc)
        .get();

    //SE CREA EL DOCUMENTO DE LA BASE PRINCIPAL
    if (!documentSnapshot.exists) {
      final InitialDoc doc = InitialDoc(
        isActive: false,
        title: 'BASE PRINCIPAL',
      );
      documentSnapshot.reference.set(doc.toJson());
    }
    */

  }

  //LEYENDO BASE UNICA PRINCIPAL
  @override
  Stream<InitialDoc> readDoc() {
    return _refDb.snapshots().map((dataDb) => InitialDoc.fromDocument(dataDb));
  }
}
