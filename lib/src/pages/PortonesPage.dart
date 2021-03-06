import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

String _mostrarArgumento = 'Test';
final prefs = new PreferenciasUsuario();
String _usuario = '';
String _servicio = '';

class PortonesPage extends StatefulWidget {
  @override
  _PortonesPageState createState() => _PortonesPageState();
}

class _PortonesPageState extends State<PortonesPage> {
  final prefs = new PreferenciasUsuario();

  void initState() {
    super.initState();
    _servicio = prefs.servicio;
    _usuario = prefs.usuario.toString();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Control de Accesos'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        children: <Widget>[
          Divider(
            height: 20,
          ),
          _logoCerberus(),
          Divider(
            height: 20,
          ),
          _activarPeatonalAcceso(),
          Divider(),
          _activarVehicularAcceso(),
          Divider(),
          _activarPeatonalSalida(),
          Divider(),
          _activarVehicularSalida(),
          Divider(
            height: 50,
          ),
          //_textoAlmacenado(_mostrarArgumento),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _activarPeatonalAcceso() {
    return ElevatedButton(
      child: Text(
        'Acceso Peatonal',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 2);
      },
    );
  }

  Widget _activarVehicularAcceso() {
    return ElevatedButton(
      child: Text(
        'Acceso Vehicular',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 1);
      },
    );
  }

  Widget _activarPeatonalSalida() {
    return ElevatedButton(
      child: Text(
        'Salida Peatonal',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 3);
      },
    );
  }

  Widget _activarVehicularSalida() {
    return ElevatedButton(
      child: Text(
        'Salida Vehicular',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 4);
      },
    );
  }

  Widget _textoAlmacenado(String valor) {
    return Center(
      child: Text(
        _mostrarArgumento,
        style: TextStyle(
            color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Future<String> _conectarWeb(
      String _servicio, String _usuario, int _emergencia) async {
    _usuario = prefs.usuario.toString();
    _servicio = prefs.servicio;
    String url = "http://alarmasvecinales.tk/checar?usuario=" +
        _usuario +
        "&servicio=" +
        _servicio;
    var respuesta = await http.get(url);
    String _resp2 = respuesta.body.toString();
    print(_resp2);
    if ((respuesta.body == null) || (respuesta.body == '')) {
      _mostrarArgumento = 'Desactivado por Administrador';
      _textoAlmacenado('Desactivado por Administrador');
    } else {
      String url2 = "http://alarmasvecinales.tk/enciende2?servicio=" +
          _servicio +
          "&usuario=" +
          _usuario +
          "&quien=" +
          _resp2 +
          "&emergencia=" +
          _emergencia.toString();

      var _respuesta2 = await http.get(url2);
      if (_respuesta2.body == null) {}
      String _resp3 = _respuesta2.body.toString();
      print(_resp3);
    }
    return (_resp2);
  }

  //salida1 = int.parse(respuesta.body.substring(11, 12));
  //print(salida1);
  //salida2 = int.parse(respuesta.body.substring(13, 14));
  //print(salida2);
  /* String str = 'bezkoder.com';
              str.substring(0,8); // bezkoder
              str.substring(2,8); // zkoder
              str.substring(3);   // koder.com*/

  /* Future<String> _desconectarWeb(String _servicio, String _usuario) async {
    _usuario = prefs.usuario.toString();
    _servicio = prefs.servicio;
    print(_usuario);
    print(_servicio);
    String url4 = "http://alarmasvecinales.tk/checar?usuario=" +
        _usuario +
        "&servicio=" +
        _servicio;
    var respuesta3 = await http.get(url4);
    String _resp4 = respuesta3.body.toString();
    print(_resp4);
    if ((respuesta3.body == null) || (respuesta3.body == '')) {
      _mostrarArgumento = 'Desactivado por Administrador';
      _textoAlmacenado('Desactivado por Administrador');
    } else {
      String url5 = "http://alarmasvecinales.tk/apaga3?servicio=" +
          _servicio +
          "&usuario=" +
          _usuario +
          "&quien=" +
          _resp4;

      var _respuesta4 = await http.get(url5);
      if (_respuesta4.body == null) {}
      String _resp5 = _respuesta4.toString();
      print(_resp5);
    }
    return (_resp4);
  }
*/
  /*Future<String> _checarStatus() async {
    _usuario = prefs.usuario.toString();
    _servicio = prefs.servicio;
    String url6 = "http://alarmasvecinales.tk/checar2?servicio=" + _servicio;
    var respuesta8 = await http.get(url6);
    String _resp8 = respuesta8.body.toString();
    print(_resp8);

    String url7 = "http://alarmasvecinales.tk/checar3?servicio=" + _servicio;
    var _respuesta9 = await http.get(url7);
    String _resp9 = _respuesta9.body.toString();
    print(_resp9);
    String _respuesta10 = _resp9 + " - " + _resp8;
    _mostrarArgumento = _respuesta10;
    return (_mostrarArgumento);
  }
*/
  Widget _logoCerberus() {
    return Image.network('http://alarmasvecinales.tk/images/logoapp.jpg',
        height: 100, width: 100);
  }
}
