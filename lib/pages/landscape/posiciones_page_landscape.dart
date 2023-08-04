import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/utils/util_idioma.dart';

import '../../models/equipo.dart';
import '../../utils/colecciones_id.dart';
import '../../utils/util_images.dart';
import '../../widgets/widget_loading.dart';
import '../../app/widgets/no_data.dart';


class PosicionesPageLandscape extends StatefulWidget {
  final CampeonatoModel campeonato;

  PosicionesPageLandscape({super.key, required this.campeonato});

  @override
  _PosicionesPageLandscapeState createState() =>
      _PosicionesPageLandscapeState();
}

class _PosicionesPageLandscapeState extends State<PosicionesPageLandscape> {
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
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _itemTituloTable('POS'),
              Expanded(child: _itemTituloTable('EQUIPO')),
              _itemTituloTable('J'),
              _itemTituloTable('G'),
              _itemTituloTable('E'),
              _itemTituloTable('P'),
              Container(
                width: 60.0,
                child: _itemTituloTable('GOL'),
              ),
              _itemTituloTable('+/-'),
              _itemTituloTable('PTS'),
              _itemTituloTable('GA'),
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
                                _itemPosicion(equipo),
                                Divider(
                                  color:
                                      _equipo.listaEquipos.indexOf(equipo) < 8
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
          )
        ],
      ),
    );
  }

  Widget _itemPosicion(Equipo equipo) {
    int n1 = equipo.gFavor;
    int n2 = equipo.gContra;

    final deuda = equipo.deuda - equipo.pagado;

    return Row(
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
        const SizedBox(width: 20.0),

        //LOGO Y NOMBRE
        Expanded(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: equipo.imagen != ''
                    ? FadeInImage(
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.fill,
                        placeholder: AssetImage(_urlImages.noImage),
                        image: CachedNetworkImageProvider(equipo.imagen),
                      )
                    : Image(
                        image: AssetImage(_urlImages.noImage),
                        height: 25.0,
                        width: 25.0,
                      ),
              ),
              const SizedBox(width: 15.0),
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
        //JUGADOS
        _itemPosicionTable(
            '${equipo.pGanados + equipo.pEmpatados + equipo.pPerdidos}'),
        //GANADOS
        _itemPosicionTable('${equipo.pGanados}'),
        //EMPATADOS
        _itemPosicionTable('${equipo.pEmpatados}'),
        //PERDIDOS
        _itemPosicionTable('${equipo.pPerdidos}'),

        //GOLES FAVOR Y EN CONTRA
        Container(
          width: 60.0,
          child: _itemPosicionTable('${equipo.gFavor}:${equipo.gContra}'),
        ),

        //DIFERENCIA
        _itemPosicionTable('${equipo.gFavor - equipo.gContra}'),

        //PUNTOS
        _itemPosicionTable('${equipo.pGanados * 3 + equipo.pEmpatados}',
            Colors.blue, 20.0, FontWeight.w500),
        //GA
//        _itemPosicionTable((equipo.gFavor / equipo.gContra) == null
//            ? (equipo.gFavor / equipo.gContra).toStringAsFixed(2)
//            : 0.toString())
        _itemPosicionTable(
          (n1 / n2).isInfinite
              ? 0.toString()
              : (n1 / n2).isNaN ? 0.toString() : (n1 / n2).toStringAsFixed(2),
        )
      ],
    );
  }

  Widget _itemTituloTable(String titulo) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      alignment: Alignment.center,
      height: 30.0,
      width: 40.0,
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _itemPosicionTable(String titulo,
      [Color? color, double? size, FontWeight? f]) {
    return Container(
      alignment: Alignment.center,
      height: 30.0,
      width: 40.0,
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: f,
        ),
      ),
    );
  }
}
