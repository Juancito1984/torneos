import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/app/utils/strings.dart';

import '../app/models/equipo.dart';
import '../app/models/jugador.dart';
import '../app/utils/colecciones_id.dart';
import '../app/utils/util_images.dart';
import '../app/widgets/widget_item_design.dart';
import '../app/widgets/loading.dart';
import '../app/widgets/no_data.dart';
import 'info_jugador_page.dart';

class JugadoresPage extends StatefulWidget {
  final CampeonatoModel campeonato;
  final Equipo equipo;

  JugadoresPage({super.key, required this.campeonato, required this.equipo});

  @override
  _JugadoresPageState createState() => _JugadoresPageState();
}

class _JugadoresPageState extends State<JugadoresPage> {
  final _jugador = Jugador();

  CollectionReference? _referenceJugadores;
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    _referenceJugadores =
        widget.campeonato.reference!.collection(coleccionTablaGoleadores);

    _stream = _referenceJugadores!
        .where('idEquipo', isEqualTo: widget.equipo.id)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, res) {
        return [
          _appBar(),
        ];
      },
      body: _body(),
    ));
  }

  Widget _appBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 220.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.equipo.name),
          ],
        ),
        background: CachedNetworkImage(
          imageUrl: widget.equipo.portada == ''
              ? UrlImages().noImage
              : widget.equipo.portada,
          errorWidget: (_, __, ___) {
            return Image.asset(UrlImages().noImage);
          },
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder(
      stream: _stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Loading();

        _jugador.getJugadoresEquipo(snapshot: snapshot);

        return _jugador.jugadoresEquipo.isEmpty
            ?  NoData(noData)
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: _jugador.jugadoresEquipo.map((jugador) {
                    return FadeIn(
                      delay: Duration(
                          milliseconds:
                              100 * _jugador.jugadoresEquipo.indexOf(jugador)),
                      child: _itemList(jugador),
                    );
                  }).toList(),
                ),
              );
      },
    );
  }

  Widget _itemList(Jugador jugador) {
    return ItemDesign(
      context: context,
      imagen: jugador.imagen,
      title: Text(
        jugador.name,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
      subtitle1: 'Fecha de nacimiento: ${jugador.fNacimiento}',
      subtitle2: 'Edad: ${jugador.edad} años',
      treailing: Text(
        jugador.category,
        style: TextStyle(
          color: jugador.edad <= 39 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        final route = MaterialPageRoute(
            builder: (context) => InfoJugador(jugador: jugador));

        Navigator.push(context, route);
      },
    );
  }
}
