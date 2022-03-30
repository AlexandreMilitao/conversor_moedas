// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controllers campos
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  void calculate() {
    setState(() {
      double real = double.parse(realController.text);
      double dolar = double.parse(dolarController.text);
      double euro = double.parse(euroController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Conversor \$"), //Titulo
        centerTitle: true, //ajuste do titulo na barra
        backgroundColor: Colors.blueGrey, // cor de fundo
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            10, 0, 10, 0), //Deixa um espaço da borda da tela
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, //Estica a coluna para pegar o maximo de tamanho possivel
            children: [
              Icon(
                Icons.attach_money,
                size: 120.0,
                color: Color(0xff0149FF),
              ),
              TextField(
                controller: realController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: Text('R\$'),
                  labelText: "Real",
                  labelStyle:
                      TextStyle(color: Color(0xff0149FF), fontSize: 25.0),
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
                controller: dolarController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: Text('US\$'),
                  labelText: "Dolar",
                  labelStyle:
                      TextStyle(color: Color(0xff0149FF), fontSize: 25.0),
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
                  labelStyle:
                      TextStyle(color: Color(0xff0149FF), fontSize: 25.0),
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
      ),
      backgroundColor: Colors.grey,
    );
  }
}
