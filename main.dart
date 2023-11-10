import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: IMC(),
    );
  }
}

class IMC extends StatefulWidget {
  @override
  _IMCState createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  final TextEditingController _peso = TextEditingController();
  final TextEditingController _altura = TextEditingController();
  String _sexo = 'Masculino';

  double _imc() {
    final double peso = double.tryParse(_peso.text) ?? 0.0;
    final double altura = double.tryParse(_altura.text) ?? 0.0;

    if (altura == 0) {
      return 0.0;
    } else {
      return peso / (altura * altura);
    }
  }

  String _calcularCategoriaIMC(double imc, String sexo) {
    if (sexo == 'Masculino') {
      if (imc < 20.7) {
        return 'Baixo peso';
      } else if (imc >= 20.7 && imc < 27.8) {
        return 'Peso normal';
      } else if (imc >= 27.9 && imc < 31.2) {
        return 'Sobrepeso';
      } else {
        return 'Obeso';
      }
    } else {
      if (imc < 19.1) {
        return 'Baixo peso';
      } else if (imc >= 19.1 && imc < 25.8) {
        return 'Peso normal';
      } else if (imc >= 27.4 && imc < 32.3) {
        return 'Sobrepeso';
      } else {
        return 'Obeso';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Text('Isabelle Vicente Oliveira'),
              ),
              SizedBox(
                child: Text('1431432312016'),
              ),
              SizedBox(
                child: TextField(
                  controller: _peso,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                child: TextField(
                  controller: _altura,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              DropdownButton<String>(
                value: _sexo,
                onChanged: (String? newValue) {
                  setState(() {
                    _sexo = newValue!;
                  });
                },
                items: <String>['Masculino', 'Feminino']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 500,
                child: ElevatedButton(
                  onPressed: () {
                    final imc = _imc();
                    final categoriaIMC = _calcularCategoriaIMC(imc, _sexo);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('IMC'),
                          content:
                              Text('Seu IMC é: $imc\nCategoria: $categoriaIMC'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Calcular IMC'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
