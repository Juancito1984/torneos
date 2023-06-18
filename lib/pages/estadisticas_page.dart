import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos/app/models/campeonato_model.dart';

import '../app/models/jugador.dart';
import '../app/utils/colecciones_id.dart';
import '../app/utils/idioma.dart';
import '../app/utils/util_images.dart';
import '../app/widgets/loading.dart';
import '../app/widgets/no_data.dart';

class EstadisticasPage extends StatefulWidget {
  final CampeonatoModel campeonato;

  EstadisticasPage({required this.campeonato});

  @override
  _EstadisticasPageState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  final _idioma = Idioma();
  final _jugador = Jugador();
  final _urlImages = UrlImages();

  CollectionReference? _referenceJugadores;

  final List<String> _tarjetas = ['goles', 'amarillas', 'rojas'];
  int _posTarjeta = 0;

  @override
  void initState() {
    super.initState();
    _referenceJugadores =
        widget.campeonato.reference!.collection(coleccionTablaGoleadores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _tituloCabecera(),
          Flexible(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    return StreamBuilder(
      stream: _referenceJugadores!.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Loading();

        _jugador.getJugadoresTG(
          snapshot: snapshot,
          tarjetas: _tarjetas,
          posTarjeta: _posTarjeta,
        );

        return _jugador.jugadores.isEmpty
            ? NoData(Idioma().noData)
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  children: _jugador.jugadores.map((Jugador jugador) {
                    int value = 0;
                    switch (_tarjetas[_posTarjeta]) {
                      case 'goles':
                        value = jugador.goles;
                        break;
                      case 'amarillas':
                        value = jugador.amarillas;
                        break;
                      case 'rojas':
                        value = jugador.rojas;
                        break;
                    }

                    return value > 0
                        ? _estadisticas(jugador, value)
                        : Container();
                  }).toList(),
                ),
              );
      },
    );
  }

  Widget _estadisticas(Jugador jugador, int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            //Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: jugador.imagen != ''
                  ? InkWell(
                      child: FadeInImage(
                        height: 40.0,
                        width: 40.0,
                        placeholder: AssetImage(_urlImages.noImage),
                        image: CachedNetworkImageProvider(jugador.imagen),
                      ),
                      onTap: () {
                        if (jugador.imagen != '') {
                          _showImage(jugador);
                        }
                      },
                    )
                  : Image(
                      image: AssetImage(_urlImages.noImage),
                      height: 40.0,
                      width: 40.0,
                    ),
            ),
            const SizedBox(width: 10.0),
            //Nombre y equipo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _itemJugador(jugador.name, Colors.blue),
                  _itemJugador(
                      jugador.equipo, Colors.black.withOpacity(0.6), 16.0),
                ],
              ),
            ),

            //Goles/Amarillas/Rojas
            Text(
              '$value',
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal),
            ),
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        )
      ],
    );
  }

  Widget _itemJugador(String value,
      [Color color = Colors.black, double size = 17.0]) {
    return Text(
      value,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _tituloCabecera() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${_idioma.nombre} y ${_idioma.equipo}'.toUpperCase(),
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            child: Text(
              _tarjetas[_posTarjeta].toUpperCase(),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () => setState(() {
              _posTarjeta = _posTarjeta + 1;
              if (_posTarjeta == 3) {
                _posTarjeta = 0;
              }
            }),
          ),
        ],
      ),
    );
  }

  void _showImage(Jugador jugador) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: CachedNetworkImageProvider(jugador.imagen),
              ),
            ),
          );
        });
  }
}
