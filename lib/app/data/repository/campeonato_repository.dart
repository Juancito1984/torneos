import 'package:torneos/app/models/campeonato_model.dart';

abstract class CampeonatoRepository {
  Stream<List<CampeonatoModel>> readCampeonatos();
}
