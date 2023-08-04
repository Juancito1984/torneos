import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:torneos/app/models/campeonato_model.dart';
import 'package:torneos/pages/partidos_fecha.dart';

import '../models/fecha.dart';
import '../utils/colecciones_id.dart';
import '../utils/util_idioma.dart';
import '../widgets/widget_loading.dart';
import '../app/widgets/no_data.dart';


class FechasPage extends StatefulWidget {
  final CampeonatoModel campeonato;

  FechasPage({required this.campeonato});

  @override
  _FechasPageState createState() => _FechasPageState();
}

class _FechasPageState extends State<FechasPage> {
  final _idioma = Idioma();
  final _fecha = Fecha();

  CollectionReference? _referenceFechas;

  bool _filtro = true;

  @override
  void initState() {
    super.initState();
    _referenceFechas = widget.campeonato.reference!.collection(coleccionFechas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: FloatingActionButton(
        tooltip: _filtro ? 'Instancias finales' : 'Mostrar fechas',
        backgroundColor: Colors.orange.withOpacity(0.6),
        child: Icon(
            _filtro
                ? FontAwesomeIcons.projectDiagram
                : FontAwesomeIcons.calendarAlt,
            size: 18.0),
        onPressed: () => setState(() {
          _filtro = !_filtro;
        }),
      ),
    );
  }

  //LISTA DE FECHAS
  Widget _body() {
    return StreamBuilder(
      stream: _referenceFechas!.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return WidgetLoading();

        _fecha.getFechas(snapshot);

        return _fecha.fechas.isEmpty
            ? NoData(_idioma.noFechas)
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _filtro
                      ? _fecha.fechas.map((f) {
                          return !f.esFinal
                              ? _itemFecha(_fecha.fechas, f)
                              : Container();
                        }).toList()
                      : _fecha.fechas.map((f) {
                          return f.esFinal
                              ? _itemFecha(_fecha.fechas, f)
                              : Container();
                        }).toList(),
                ),
              );
      },
    );
  }
  //OK

  //ITEM FECHAS DISPONIBLES
  Widget _itemFecha(List<Fecha> fechas, Fecha fecha) {
    return GestureDetector(
      child: FadeInLeft(
        delay: Duration(milliseconds: 80 * fechas.indexOf(fecha)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          padding: const EdgeInsets.only(right: 5.0),
          height: 60.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: <Widget>[
              //Dia y Fecha
              Expanded(
                child: Text(
                  '${fecha.dia}\n${fecha.fecha}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //Nombre fecha y Estado
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                alignment: Alignment.center,
                width: 110.0,
                height: 55.0,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      fecha.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    !fecha.esFinal
                        ? Text(
                            fecha.jugado ? 'JUGADA' : 'POR JUGAR',
                            style: TextStyle(
                              color: fecha.jugado ? Colors.red : Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              //Ida vuelta
              !fecha.esFinal
                  ? Expanded(
                      child: Text(
                        fecha.idaVuelta,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Expanded(
                      child: Text(
                        fecha.jugado ? 'Jugado' : fecha.idaVuelta,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: fecha.jugado ? Colors.red : Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      onTap: () {
        final route = MaterialPageRoute(
          builder: (context) => PartidosFecha(
            fecha: fecha,
            campeonato: widget.campeonato,
          ),
        );
        Navigator.push(context, route);
      },
    );
  }
}
