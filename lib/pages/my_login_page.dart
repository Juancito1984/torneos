import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app/theme/app_colors.dart';
import '../utils/util_idioma.dart';
import '../utils/util_images.dart';
import 'my_home_page.dart';


/*
class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _urlImages = UrlImages();
  final _idioma = Idioma();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //FOndo de pantalla
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage(_urlImages.fondoLogin),
              fit: BoxFit.cover,
            ),
          ),

          //Efecto para el fondo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff216971),
                  const Color(0xffBE9E34).withOpacity(0.64),
                ],
              ),
            ),
          ),

          //Contenido
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                //Texto superior
                _textHelper(_idioma.nota, 16.0),

                //Logo de App
                _imagenCentral(),
                const SizedBox(height: 80.0),

                //Boton de inicio de sesion
                _loginButton(),

                //Ayuda boton de inicio
                _textHelper(_idioma.iniciaConGoogle, 13.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagenCentral() {
    return Image.asset(
      _urlImages.newLogoApp,
      height: 250.0,
    );
  }

  Widget _textHelper(String title, double size) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: size,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 50.0,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                height: 35.0,
                width: 35.0,
                image: AssetImage(_urlImages.iconGoogle),
              ),
              const SizedBox(width: 10.0),
              Text(
                _idioma.google.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        onTap: () {
          _login()
              .then((value) => print(value!.displayName))
              .catchError((e) => print('ERROR: $e'));
        });
  }

  Future<User?> _login() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    User? firebaseUser;

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      firebaseUser = (await _auth.signInWithCredential(credential)).user;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    }

    return firebaseUser;
  }
}
*/