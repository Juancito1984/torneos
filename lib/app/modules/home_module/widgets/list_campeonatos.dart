import 'package:flutter/material.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/app/modules/home_module/widgets/item_campeonato.dart';
import 'package:torneos/app/widgets/no_data.dart';

class ListCampeonatos extends StatelessWidget {
  final List<CampeonatoModel> campeonatos;

  const ListCampeonatos({
    super.key,
    required this.campeonatos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: campeonatos.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final campeonato = campeonatos[index];

        return
            ItemCampeonato(campeonato: campeonato);

      },
    );
  }
}
