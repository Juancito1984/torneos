import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app/models/encuentro.dart';
import '../app/models/jugador.dart';
import '../app/utils/colecciones_id.dart';
import '../app/utils/idioma.dart';
import '../app/widgets/loading.dart';
import '../app/widgets/no_data.dart';
import '../app/widgets/widget_tarjeta.dart';


class ResumenPage extends StatefulWidget {
  final Encuentro encuentro;

  ResumenPage({
    required this.encuentro,
  });

  @override
  _ResumenPageState createState() => _ResumenPageState();
}

class _ResumenPageState extends State<ResumenPage> {
  final _idioma = Idioma();
  final _jugador = Jugador();

  CollectionReference? _referenceJugadoresA;
  CollectionReference? _referenceJugadoresB;

  @override
  void initState() {
    super.initState();

    _referenceJugadoresA = widget.encuentro.reference!.collection(jugadoresA);
    _referenceJugadoresB = widget.encuentro.reference!.collection(jugadoresB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          _idioma.titleResumen.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          //EQUIPOS JUGANDO
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            color: Colors.grey.withOpacity(0.3),
            child: WidgetTarjeta(encuentro: widget.encuentro),
          ),
          const SizedBox(height: 5.0),
          //LISTA DE JUGADORES DE AMBOS EQUIPOS
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _listaJugadoresA()),
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: 1.0,
                  color: Colors.red,
                ),
                Expanded(child: _listaJugadoresB()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaJugadoresA() {
    return StreamBuilder(
        stream: _referenceJugadoresA!.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Loading();

          _jugador.getJugadoresResumen(snapshot);

          return _jugador.jugadoresResumen.isEmpty
              ? NoData('No Data')
              : SingleChildScrollView(
                  child: Column(
                    children: _jugador.jugadoresResumen.map((Jugador jugador) {
                      return _itemList(jugador);
                    }).toList(),
                  ),
                );
        });
  }

  Widget _listaJugadoresB() {
    return StreamBuilder(
        stream: _referenceJugadoresB!.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Loading();

          _jugador.getJugadoresResumen(snapshot);

          return _jugador.jugadoresResumen.isEmpty
              ? NoData('No Data')
              : SingleChildScrollView(
                  child: Column(
                    children: _jugador.jugadoresResumen.map((Jugador jugador) {
                      return _itemList(jugador);
                    }).toList(),
                  ),
                );
        });
  }

  Widget _itemList(Jugador jugador) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              //Dorsal
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 25.0,
                  width: 25.0,
                  color: Colors.blue,
                  child: Text(
                    jugador.dorsal,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              //Nombre
              Expanded(
                child: Text(
                  jugador.name,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              //GOLES
              _itemGAR(
                  icon: FontAwesomeIcons.futbol,
                  color: Colors.green,
                  value: jugador.goles),

              //AMARILLAS
              _itemGAR(
                icon: Icons.book,
                color: Colors.yellow,
                value: jugador.amarillas,
              ),

              //ROJAS
              _itemGAR(
                icon: Icons.book,
                color: Colors.red,
                value: jugador.rojas,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemGAR({IconData? icon, Color? color, int? value}) {
    return value! > 0
        ? Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: Row(
              children: <Widget>[
                Icon(icon, color: color),
                Text(
                  ' $value',
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Container();
  }
}
