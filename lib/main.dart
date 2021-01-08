import 'package:flutter/material.dart';
import 'package:cloud_cerberus_v4/src/pages/HomePage.dart';
import 'package:cloud_cerberus_v4/src/pages/SettingsPage.dart';
import 'package:cloud_cerberus_v4/src/pages/PortonesPage.dart';
import 'package:cloud_cerberus_v4/src/pages/ContactsPage.dart';
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';

String _servicio = '';
String _usuario = '';
int valorInicial2 = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
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
      print('Fue Cero');
    } else {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigationBar2(),
      );
      print('Fue Uno ');
    }
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
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
    );
  }
}

class MyBottomNavigationBar2 extends StatefulWidget {
  @override
  _MyBottomNavigationBar2State createState() => _MyBottomNavigationBar2State();
}

class _MyBottomNavigationBar2State extends State<MyBottomNavigationBar2> {
  @override
  int _currentIndex = 0;

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

  @override
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
    );
  }
}
