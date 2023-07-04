import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/app/theme/app_colors.dart';
import 'package:torneos/pages/resumen_page.dart';

import '../app/models/encuentro.dart';
import '../app/models/fecha.dart';
import '../app/utils/colecciones_id.dart';
import '../app/utils/strings.dart';
import '../app/utils/util_images.dart';
import '../app/widgets/loading.dart';
import '../app/widgets/no_data.dart';

class PartidosFecha extends StatefulWidget {
  final Fecha fecha;
  final CampeonatoModel campeonato;

  const PartidosFecha({
    super.key,
    required this.fecha,
    required this.campeonato,
  });

  @override
  _PartidosFechaState createState() => _PartidosFechaState();
}

class _PartidosFechaState extends State<PartidosFecha> {
  //ACCESO A MODELOS Y UTILIDADES
  final _urlImages = UrlImages();
  final _encuentro = Encuentro();

  //ACCESO A LA BASE DE DATOS
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();

    _stream =
        widget.fecha.reference!.collection(coleccionEncuentros).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fecha.index <= widget.campeonato.cantFechas
              ? 'Partidos ${widget.fecha.name}'.toUpperCase()
              : widget.fecha.name.toUpperCase(),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(
              '${widget.fecha.dia}\n${widget.fecha.fecha}',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      body: _body(),
    );
  }

  //PARTIDOS DE LA FECHA
  Widget _body() {
    return StreamBuilder(
      stream: _stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Loading();

        _encuentro.getEncuentros(snapshot);

        return _encuentro.encuentros.isEmpty
            ? const NoData(noPartidos)
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _encuentro.encuentros.map((Encuentro encuentro) {
                    return _itemPartido(encuentro);
                  }).toList(),
                ),
              );
      },
    );
  }

  Widget _itemPartido(Encuentro encuentro) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Equipo A => Logo y Nombre
            Expanded(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: encuentro.logoA != ''
                        ? FadeInImage(
                            height: 30.0,
                            width: 30.0,
                            placeholder: AssetImage(_urlImages.noImage),
                            image: CachedNetworkImageProvider(encuentro.logoA),
                          )
                        : Image(
                            image: AssetImage(_urlImages.noImage),
                            height: 40.0,
                            width: 40.0),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Text(
                      encuentro.equipoA,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5.0),
            //Estado del encuentro
            Container(
              alignment: Alignment.center,
              width: 85.0,
              height: 50.0,
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    encuentro.estado.capitalize!,
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),

                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    encuentro.estado != 'hora'
                        ? '${encuentro.goolA} - ${encuentro.goolB}'
                        : encuentro.hora,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5.0),
            //Equipo B => Nombre y Logo
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      encuentro.equipoB,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: encuentro.logoB != ''
                        ? FadeInImage(
                            height: 30.0,
                            width: 30.0,
                            placeholder: AssetImage(_urlImages.noImage),
                            image: CachedNetworkImageProvider(encuentro.logoB),
                          )
                        : Image(
                            image: AssetImage(_urlImages.noImage),
                            height: 40.0,
                            width: 40.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (encuentro.estado != hora) {
          final route = MaterialPageRoute(
            builder: (context) => ResumenPage(encuentro: encuentro),
          );

          Navigator.push(context, route);
        }
      },
      onLongPress: () {
        if (encuentro.comentario != '') {
          _showInconveniente(encuentro);
        }
      },
    );
  }

  void _showInconveniente(Encuentro encuentro) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(encuentro.estado),
          content: Text(encuentro.comentario),
          actions: <Widget>[
            ElevatedButton(
              child: Text(aceptar),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
