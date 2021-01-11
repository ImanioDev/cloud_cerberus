import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

String _mostrarArgumento = 'Test';
final prefs = new PreferenciasUsuario();
String _usuario = '';
String _servicio = '';
int esperate = 0;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final prefs = new PreferenciasUsuario();

  void initState() {
    super.initState();
    _servicio = prefs.servicio;
    _usuario = prefs.usuario.toString();

    Timer _timer;
    print(_timer);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted == true) {
        setState(() {
          if (esperate == 0) {
            _mostrarArgumento = prefs.argumentoFinal;
          }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Alarma'),
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
          _activarEmergencia(),
          Divider(
            height: 10,
          ),
          _activarMedica(),
          Divider(
            height: 10,
          ),
          _activarViolencia(),
          Divider(
            height: 10,
          ),
          _desactivarTodo(),
          Divider(
            height: 20,
          ),
          _textoAlmacenado(_mostrarArgumento),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _activarEmergencia() {
    return ElevatedButton(
      child: Text(
        'Robo o Allanamiento',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 1);
      },
    );
  }

  Widget _activarMedica() {
    return ElevatedButton(
      child: Text(
        'Medica',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 2);
      },
    );
  }

  Widget _activarViolencia() {
    return ElevatedButton(
      child: Text(
        'Violencia',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _conectarWeb(_servicio, _usuario, 3);
      },
    );
  }

  Widget _desactivarTodo() {
    return ElevatedButton(
      child: Text(
        'Desactivar Alarma',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        _desconectarWeb(_servicio, _usuario);
      },
    );
  }

  Widget _textoAlmacenado(String valor) {
    return Center(
      child: Text(
        prefs.argumentoFinal,
        style: TextStyle(
            color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Future<String> _conectarWeb(
      String _servicio, String _usuario, int _emergencia) async {
    esperate = 1;
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
      String url2 = "http://alarmasvecinales.tk/enciende3?servicio=" +
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
    esperate = 0;
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

  Future<String> _desconectarWeb(String _servicio, String _usuario) async {
    esperate = 1;
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
      String _resp5 = _respuesta4.body.toString();
      print(_resp5);
    }
    esperate = 0;
    return (_resp4);
  }

  /*Future<String> _checarStatus() async {
    esperate = 1;
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
    esperate = 0;
    return (_mostrarArgumento);
  }*/

  Widget _logoCerberus() {
    return Image.network('http://alarmasvecinales.tk/images/logoapp.jpg',
        height: 100, width: 100);
  }
}
