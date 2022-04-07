// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, non_constant_identifier_names, import_of_legacy_library_into_null_safe, avoid_print, missing_return
//@dart =2.9
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=de791ef7";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

void main() async {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        hintColor: Colors.black,
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.black),
        )),
  ));
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controllers campos
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else {
      double real = double.parse(text);

      //fixa a casa decimal
      dolarController.text = (real / dolar).toStringAsFixed(2);
      euroController.text = (real / euro).toStringAsFixed(2);
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else {
      double dolar = double.parse(text);
      realController.text = (dolar * this.dolar).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else {
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    }
  }

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
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados.",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dadors :(.",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding:
                      EdgeInsets.all(10), //Deixa um espaço da borda da tela
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, //Estica a coluna para pegar o maximo de tamanho possivel
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Color(0xff0149FF),
                      ),
                      buildTextField(
                          "Real", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField(
                          "Dólar", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField(
                          "Euros", "€", euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixText: prefix,
      labelText: label,
      labelStyle: TextStyle(color: Color(0xff0149FF), fontSize: 25.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0149FF)),
      ),
    ),
    textAlign: TextAlign.left,
    onChanged: f,
  );
}
