import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del Genero
  get usuario {
    return _prefs.getInt('usuario') ?? 1;
  }

  set usuario(int value) {
    _prefs.setInt('usuario', value);
  }

// GET y SET del Genero
  get pausado {
    return _prefs.getInt('pausado') ?? 1;
  }

  set pausado(int value) {
    _prefs.setInt('pausado', value);
  }

  // GET y SET del nombreUsuario
  get servicio {
    return _prefs.getString('servicio') ?? '';
  }

  set servicio(String value) {
    _prefs.setString('servicio', value);
  }

  get validezMemoria {
    return _prefs.getString('validezMemoria') ?? '';
  }

  set validezMemoria(String value) {
    _prefs.setString('validezMemoria', value);
  }

  get argumentoFinal {
    return _prefs.getString('argumentoFinal') ?? '';
  }

  set argumentoFinal(String value) {
    _prefs.setString('argumentoFinal', value);
  }
}
