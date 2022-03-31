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
                dolar = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      10, 0, 10, 0), //Deixa um espaço da borda da tela
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, //Estica a coluna para pegar o maximo de tamanho possivel
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Color(0xff0149FF),
                        ),
                        TextField(
                          controller: realController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            prefix: Text('R\$'),
                            labelText: "Real",
                            labelStyle: TextStyle(
                              color: Color(0xff0149FF),
                              fontSize: 25.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff0149FF),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: dolarController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefix: Text('US\$'),
                            labelText: "Dólar",
                            labelStyle: TextStyle(
                                color: Color(0xff0149FF), fontSize: 25.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff0149FF),
                              ),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: euroController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefix: Text('€'),
                            labelText: "Euro",
                            labelStyle: TextStyle(
                                color: Color(0xff0149FF), fontSize: 25.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff0149FF),
                              ),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
