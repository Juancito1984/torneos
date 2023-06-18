class Idioma {
  Idioma._internal();

  static final _instancia = Idioma._internal();

  factory Idioma() {
    return _instancia;
  }

  //GLOBAL TEXT
  final String developers =
      'Desarrollada por:\nIng. Juan Pablo Gosalvez\n(NyK Service)\nCel: 73734219';
  final String noCampeonato = 'No disponibles';
  final String noFechas = 'Fechas no registradas';
  final String noPartidos = 'No registrados';
  final String cancelar = 'Cancelar';
  final String aceptar = 'Aceptar';

  //DRAWER TEXT
  final String salirDeApp = 'Deseas salir de la aplicacion?';
  final String user = 'LIGA DE PROFESIONALES';
  final String email = 'miligalpf7rib@gmail.com';
  final String titleAcerca = 'Acerca de...';
  final String despAcerca = 'Informacion acerca de la aplicacion';
  final String cerrarSesion = 'Cerrar sesion';
  final String despcerrarSesion = 'Salir de la cuenta';
  final String listaEquipos = 'Equipos';
  final String despListaEquipos = 'Ver equipos participantes';
  final String titleSalir = 'Salir';
  final String despSalir = 'Salir de la aplicacion';

  //LOGIN PAGE
  final String iniciaConGoogle = 'Inicia sesion con tu cuenta de google';
  final String google = 'Iniciar con google';
  final String nota =
      'Torneos utiliza datos sensibles guardados en la nube por consiguiente es necesario que inicies sesion.';

  //HOME PAGE
  final String cargando = 'Cargando...';
  final String titleHomePage = 'Torneos';
  final String userAcount = 'Liga de profesionales futbol 7';
  final String idadVuelta = 'Ida y vuelta';
  final String soloIda = 'Solo Ida';

  //INITIAL PAGE
  final String titleInitialPage = 'Pagina de inicio';
  final String fechas = 'Fechas';
  final String posiciones = 'Posiciones';
  final String estadisticas = 'Estadísticas';

  //PARTIDOS FECHA
  final String hora = 'Hora';

  //RESUMEN DEL PARTIDO
  final String titleResumen = 'Resumen del partido';

  //GOLEADORES
  final String nombre = 'Nombre';
  final String equipo = 'Equipo';
  final String goles = 'Goles';
  final String amarillas = 'Amarillas';
  final String rojas = 'Rojas';

  //POSICIONES
  final String jugadores = 'Jugadores';

  //CLASIFICATORIO
  final String titleClasificatorio = 'Clasificatorio';

  //INFORMACION DEL JUGADOR
  final String infoJugador = 'Informacion del jugador';

  final String noData = 'No hay datos';
  final String baseDesactivada = 'Base de datos desactivada';
}
