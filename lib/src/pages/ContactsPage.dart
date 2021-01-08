import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_cerberus_v4/src/share_prefs/preferencias_usuario.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      appBar: new AppBar(
        title: new Text('Contacto'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/src/images/contacto.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: new Text(''),
        ),
      ),
    );
  }
}
