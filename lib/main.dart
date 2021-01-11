import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_cerberus_v4/src/pages/HomePage.dart';
import 'package:cloud_cerberus_v4/src/pages/SettingsPage.dart';
import 'package:cloud_cerberus_v4/src/pages/PortonesPage.dart';
import 'package:cloud_cerberus_v4/src/pages/ContactsPage.dart';
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_phoenix/flutter_phoenix.dart';

String _servicio = '';
//String _usuario = '';
//String _mostrarArgumento = '';

int valorInicial2 = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    valorInicial = prefs.validezMemoria;
    if (valorInicial == '') {
      valorInicial2 = 0;
    } else {
      valorInicial2 = int.parse(valorInicial);
    }
    print('Valor = ' + valorInicial);
    if (valorInicial2 == 0) {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigationBar(),
      );
    } else {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigationBar2(),
      );
    }
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  //@override
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    HomePage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home), label: 'Validar Usuario'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.home,
                  color: new Color.fromARGB(255, 255, 255, 255)),
              label: ''),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => exit(0),
        tooltip: 'salir',
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}

class MyBottomNavigationBar2 extends StatefulWidget {
  @override
  _MyBottomNavigationBar2State createState() => _MyBottomNavigationBar2State();
}

class _MyBottomNavigationBar2State extends State<MyBottomNavigationBar2> {
  //@override
  int _currentIndex = 0;

  final prefs = new PreferenciasUsuario();

  void initState() {
    super.initState();
    _servicio = prefs.servicio;
    // _usuario = prefs.usuario.toString();

    Timer _timer;
    print(_timer);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //if (mounted == true) {
      setState(() {
        //if (esperate == 0) {
        _checarStatus();
        //}
      });
      //}
    });
  }

  final List<Widget> _children = [
    SettingsPage(),
    PortonesPage(),
    ContactsPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.settings), label: 'Alarma'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.contacts), label: 'Portones'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.contacts), label: 'Contacto'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => exit(0),
        tooltip: 'salir',
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }*/

  Future<String> _checarStatus() async {
    esperate = 1;
    //_usuario = prefs.usuario.toString();
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

    setState(() {
      prefs.argumentoFinal = _respuesta10;
    });
    esperate = 0;
    return (prefs.argumentoFinal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onTap: onTappedBar,
        //currentIndex: _currentIndex,
        items: <Widget>[
          Icon(Icons.add_alarm_outlined, size: 30, color: Colors.white),
          Icon(Icons.amp_stories_outlined, size: 30, color: Colors.white),
          Icon(Icons.contacts, size: 30, color: Colors.white),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => exit(0),
        tooltip: 'salir',
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}
