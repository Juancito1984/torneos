//Extrear edad del usuario
int getEdad(String fechaNacimiento) {
  int edad = 0;

  int diaActual, mesActual, yearActual;
  int dia, mes, year;

  //DATOS FECHA ACTUAL
  final fechaActual = DateTime.now();
  diaActual = fechaActual.day;
  mesActual = fechaActual.month;
  yearActual = fechaActual.year;

  //DATOS FECHA DE NACIMIENTO
  dia = int.parse(fechaNacimiento.substring(0, 2));
  mes = int.parse(fechaNacimiento.substring(3, 5));
  year = int.parse(fechaNacimiento.substring(6));

  //DIA MENOR
  if (dia < diaActual && mes < mesActual) {
    edad = yearActual - year;
  } else if (dia < diaActual && mes > mesActual) {
    edad = (yearActual - 1) - year;
  } else if (dia < diaActual && mes == mesActual) {
    edad = yearActual - year;

    //DIA MAYOR
  } else if (dia > diaActual && mes < mesActual) {
    edad = yearActual - year;
  } else if (dia > diaActual && mes > mesActual) {
    edad = (yearActual - 1) - year;
  } else if (dia > diaActual && mes == mesActual) {
    edad = (yearActual - 1) - year;

    //DIA IGUAL
  } else if (dia == diaActual && mes < mesActual) {
    edad = yearActual - year;
  } else if (dia == diaActual && mes > mesActual) {
    edad = (yearActual - 1) - year;
  } else if (dia == diaActual && mes == mesActual) {
    edad = yearActual - year;
  }

  return edad;
}