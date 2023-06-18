
import '../../models/initial_doc.dart';

abstract class MatrixDbRepository{

  createDb();
  Stream<InitialDoc>readDoc();


}