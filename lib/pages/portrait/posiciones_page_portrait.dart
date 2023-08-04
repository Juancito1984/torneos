import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos/app/models/campeonato_model.dart';

import '../../models/my_campeonato.dart';
import '../../models/equipo.dart';
import '../../utils/colecciones_id.dart';
import '../../utils/util_idioma.dart';
import '../../utils/util_images.dart';
import '../../widgets/widget_loading.dart';
import '../../app/widgets/no_data.dart';
import '../jugadores_page.dart';

class PosicionesPagePortrait extends StatefulWidget {
  final CampeonatoModel campeonato;

  PosicionesPagePortrait({
    super.key,
    required this.campeonato,
  });

  @override
  _PosicionesPagePortraitState createState() => _PosicionesPagePortraitState();
}

class _PosicionesPagePortraitState extends State<PosicionesPagePortrait> {
  final _equipo = Equipo();
  final _urlImages = UrlImages();

  CollectionReference? _referenceEquipos;

  @override
  void initState() {
    super.initState();
    _referenceEquipos =
        widget.campeonato.reference!.collection(coleccionEquipos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _itemTituloTable('POS'),
            Expanded(child: _itemTituloTable('EQUIPO')),
            _itemTituloTable('J'),
            SizedBox(
              width: 60.0,
              child: _itemTituloTable('GOL'),
            ),
            _itemTituloTable('+/-'),
            _itemTituloTable('PTS'),
          ],
        ),
        Expanded(
          child: StreamBuilder(
            stream: _referenceEquipos!.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return WidgetLoading();

              _equipo.getEquipos(snapshot);

              return _equipo.listaEquipos.isEmpty
                  ? NoData(Idioma().noData)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: _equipo.listaEquipos.map((equipo) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FadeIn(
                                delay: Duration(
                                    milliseconds: 100 *
                                        _equipo.listaEquipos.indexOf(equipo)),
                                child: _itemEquipo(equipo),
                              ),
                              Divider(
                                color: _equipo.listaEquipos.indexOf(equipo) < 8
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _itemEquipo(Equipo equipo) {
    final deuda = equipo.deuda - equipo.pagado;
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //POSICION
          Container(
            alignment: Alignment.center,
            width: 40.0,
            child: Text(
              '${_equipo.listaEquipos.indexOf(equipo) + 1}',
              style: TextStyle(
                  fontSize: 16.0,
                  color: _equipo.listaEquipos.indexOf(equipo) < 8
                      ? Colors.green
                      : Colors.red),
            ),
          ),

          //LOGO Y NOMBRE DEL EQUIPO
          Expanded(
            child: Row(
              children: [
                //IMAGEN
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: equipo.imagen != ''
                        ? FadeInImage(
                            height: 25.0,
                            width: 25.0,
                            fit: BoxFit.cover,
                            placeholder: AssetImage(_urlImages.noImage),
                            image: CachedNetworkImageProvider(equipo.imagen),
                          )
                        : Image(
                            image: AssetImage(_urlImages.noImage),
                            height: 25.0,
                            width: 25.0,
                          ),
                  ),
                  onTap: () {
                    _showImage(equipo.imagen);
                  },
                ),

                const SizedBox(width: 10.0),

                //NOMBRE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        equipo.name,
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      deuda > 0
                          ? Text(
                              'Deuda: $deuda Bs',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),

          //PARTIDOS JUGADOS
          _itemPosicionTable(
              '${equipo.pGanados + equipo.pEmpatados + equipo.pPerdidos}'),

          //Goles favor y en contra
          SizedBox(
            width: 60.0,
            child: _itemPosicionTable('${equipo.gFavor}:${equipo.gContra}'),
          ),

          //DIFERENCIA
          _itemPosicionTable('${equipo.gFavor - equipo.gContra}'),

          //PUNTOS
          _itemPosicionTable('${equipo.pGanados * 3 + equipo.pEmpatados}',
              Colors.blue, 20.0, FontWeight.w500)
        ],
      ),
      onTap: () {
        final route = MaterialPageRoute(
            builder: (context) => JugadoresPage(
                  campeonato: widget.campeonato,
                  equipo: equipo,
                ));
        Navigator.push(context, route);
      },
    );
  }

  Widget _itemTituloTable(String titulo) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      alignment: Alignment.center,
      width: 40.0,
      height: 30.0,
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _itemPosicionTable(String titulo,
      [Color? color, double size = 12.0, FontWeight? fontWeight]) {
    return Container(
      alignment: Alignment.center,
      width: 40.0,
      height: 30.0,
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  //VER IMAGEN DEL JUGADOR
  void _showImage(String urlImage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: urlImage != ''
              ? Image(
                  image: CachedNetworkImageProvider(urlImage),
                )
              : Image(image: AssetImage(_urlImages.noImage)),
        ),
      ),
    );
  }
}
