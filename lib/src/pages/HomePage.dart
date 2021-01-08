import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';

int salida1 = 0;
int salida2 = 0;
int validez = 0;
int validezalmacenada = 0;
String valorInicial = '';
String _usuario = '';
String _password = '';
String _servicio = '';
String mostrarArgumento = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final prefs = new PreferenciasUsuario();

  void initState() {
    super.initState();
    valorInicial = prefs.validezMemoria;
    _servicio = prefs.servicio;
    _usuario = prefs.usuario.toString();
    mostrarArgumento = 'Favor de rellenar todos los campos';
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Validar Usuario'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        children: <Widget>[
          Divider(
            height: 30,
          ),
          _logoCerberus(),
          Divider(
            height: 30,
          ),
          _crearUsuario(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearServicio(),
          Divider(),
          _botonEncenderAlarma(),
          Divider(),
          _textoAlmacenado(mostrarArgumento),
        ],
      ),
    );
  }

  Widget _botonEncenderAlarma() {
    return ElevatedButton(
      child: Text(
        'Validar',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        pedirdatos();
      },
    );
  }

  Widget _textoAlmacenado(String valor) {
    return Center(
      child: Text(
        mostrarArgumento,
        style: TextStyle(
            color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _crearUsuario() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_usuario.length}'),
          hintText: 'Numero de Usuario',
          labelText: 'Usuario',
          helperText: 'Numero de Usuario que se asignó en plataforma',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _usuario = valor;
        });
      },
    );
  }

  Widget _crearPassword() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_password.length}'),
          hintText: 'Password',
          labelText: 'Password',
          helperText: 'Password provisto al administrador',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
    );
  }

  Widget _crearServicio() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_servicio.length}'),
          hintText: 'Numero de Servicio',
          labelText: 'Numero de Servicio',
          helperText: 'Numero de Servicio provisto al Administrador',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _servicio = valor;
        });
      },
    );
  }

  Future<String> pedirdatos() async {
    if (_servicio != '' && _password != '' && _usuario != '') {
      String url = "http://alarmasvecinales.tk/grabar?verify=" +
          _password +
          "&servicio=" +
          _servicio;
      var respuesta = await http.get(url);
      String resp2 = respuesta.toString();
      if ((respuesta.body == null) || (respuesta.body == '')) {
        print("Devolvio 0...");
        prefs.validezMemoria = '0';
        valorInicial = prefs.validezMemoria;
        mostrarArgumento = 'Valores Incorrectos...';
        setState(() {});
      } else {
        validez = int.parse(respuesta.body.substring(0, 1));
        prefs.validezMemoria = validez.toString();
        valorInicial = prefs.validezMemoria;
        prefs.servicio = _servicio;
        prefs.usuario = int.parse(_usuario);
        mostrarArgumento = 'Salga de la aplicación y vuelva a ingresar...';
        setState(() {});
        print(validez);
      }
    }

    //salida1 = int.parse(respuesta.body.substring(11, 12));
    //print(salida1);
    //salida2 = int.parse(respuesta.body.substring(13, 14));
    //print(salida2);
    /* String str = 'bezkoder.com';
              str.substring(0,8); // bezkoder
              str.substring(2,8); // zkoder
              str.substring(3);   // koder.com*/
  }

  Widget _logoCerberus() {
    return Image.network('http://alarmasvecinales.tk/images/logoapp.jpg',
        height: 100, width: 100);
  }
}
