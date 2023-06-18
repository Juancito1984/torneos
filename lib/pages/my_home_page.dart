import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:torneos/app/theme/app_colors.dart';

import '../models/my_campeonato.dart';
import '../utils/colecciones_id.dart';
import '../utils/util_colors.dart';
import '../utils/util_idioma.dart';
import '../utils/util_images.dart';
import '../widgets/card_campeonatos.dart';
import '../widgets/widget_loading.dart';
import '../app/widgets/no_data.dart';
import 'my_login_page.dart';

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _urlImages = UrlImages();
  final _idioma = Idioma();
  final _colors = UtilColors();
  final _campeonato = MyCampeonato();

  User? user;
  CollectionReference? _referenceBase;

  PackageInfo _infoApps = PackageInfo(
    version: '',
    appName: '',
    packageName: '',
    buildNumber: '',
  );

  //INFORMACION SORE LA APLICACION
  Future<Null> _initInfoApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _infoApps = packageInfo;
    });
  }

  //Programamos el boton atras
  // Future<bool> _buildAtras() {
  _buildAtras() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_idioma.salirDeApp),
        actions: <Widget>[
          TextButton(
            child: Text(_idioma.cancelar),
            onPressed: () => Navigator.pop(context, false),
          ),
          MaterialButton(
            color: primaryColor,
            textColor: Colors.white,
            onPressed: () => SystemNavigator.pop(),
            child: Text(_idioma.aceptar),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _initInfoApp();
    _referenceBase = FirebaseFirestore.instance
        .collection(coleccionBase)
        .doc(initialDoc)
        .collection(coleccionTorneos);
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(title: Text(_idioma.titleHomePage.toUpperCase())),
      body: _body(),
    );
    /*
    return WillPopScope(
      onWillPop: _buildAtras,
      child: Scaffold(
        drawer: _drawer(),
        appBar: AppBar(title: Text(_idioma.titleHomePage.toUpperCase())),
        body: _body(),
      ),
    );

    */
  }

  //CAJON DE OPCIONES
  Widget _drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                user!.photoURL == null ? _urlImages!.logoUser : user!.photoURL!,
              ),
            ),
            // accountName: Text(_idioma.user),
            // accountEmail: Text(_idioma.email),
            accountName: user!.displayName == null
                ? Text(_idioma.user)
                : Text(user!.displayName!),
            accountEmail:
                user!.email == null ? Text(_idioma.email) : Text(user!.email!),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Acerca de...
                  ListTile(
                    leading: Icon(FontAwesomeIcons.infoCircle,
                        size: 20.0, color: _colors.primaryColor),
                    title: Text(_idioma.titleAcerca),
                    subtitle: Text(_idioma.despAcerca),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: _colors.accentColor),
                    onTap: () {
                      Navigator.pop(context);
                      _acercaDe();
                    },
                  ),
                  //Cerrar sesion
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorOpen,
                        size: 20.0, color: _colors.primaryColor),
                    title: Text(_idioma.cerrarSesion),
                    subtitle: Text(_idioma.despcerrarSesion),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: _colors.accentColor),
                    onTap: () {
                      _cerrarSesion();
                      Navigator.pop(context);
                    },
                  ),

                  //Salir de la aplicacion
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorClosed,
                        size: 20.0, color: _colors.primaryColor),
                    title: Text(_idioma.titleSalir),
                    subtitle: Text(_idioma.despSalir),
                    trailing: Icon(Icons.arrow_forward,
                        size: 25.0, color: _colors.accentColor),
                    onTap: () {
                      Navigator.pop(context);
                      _buildAtras();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //CUERPO DE LA APLICACION
  Widget _body() {
    return StreamBuilder(
      stream: _referenceBase!.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return WidgetLoading();

        _campeonato.getCampeonatos(snapshot);

        return _campeonato.campeonatos.isEmpty
            ? WidgetNoData(_idioma.noCampeonato)
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _campeonato.campeonatos.map((MyCampeonato camp) {
                    return FadeInLeft(
                      delay: Duration(
                          milliseconds:
                              100 * _campeonato.campeonatos.indexOf(camp)),
                      child: CardCampeonatos(campeonato: camp),
                    );
                  }).toList(),
                ),
              );
      },
    );
  }

  //INFORMACION ACERCA DE LA APLICACION
  void _acercaDe() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    _infoApps.appName.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                  const SizedBox(height: 10.0),
                  CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(_urlImages.logoUser),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Version: ${_infoApps.version}',
                    style: const TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    _idioma.developers,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 0.0,
                color: _colors.buttonColor.withOpacity(0.7),
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context),
                child: Text(_idioma.aceptar),
              )
            ],
          );
        });
  }

  //CERRAR SESION
  void _cerrarSesion() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MyLoginPage(),
    //   ),
    // );
  }
}
*/