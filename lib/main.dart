// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, non_constant_identifier_names, import_of_legacy_library_into_null_safe, avoid_print, missing_return
//@dart =2.9
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=de791ef7W";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  json.decode(response.body);
}

void main() async {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controllers campos
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  double real;
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("\$ Conversor \$"), //Titulo
        centerTitle: true, //ajuste do titulo na barra
        backgroundColor: Colors.blueGrey, // cor de fundo
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados.",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapShot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dadors :(.",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = ;
                return Container(
                  color: Colors.green,
                );
              }
          }
        },
      ),
    );
  }
}
