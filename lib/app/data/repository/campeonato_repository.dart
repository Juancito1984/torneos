import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/models/my_campeonato.dart';

abstract class CampeonatoRepository {
  Stream<List<CampeonatoModel>> readCampeonatos();
}
