import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _defaultMessage = 'Informe seus dados!';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _defaultMessage = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _defaultMessage = 'Abaixo do Peso';
      } else if (imc < 25) {
        _defaultMessage = 'Peso Ideal';
      } else if (imc < 30) {
        _defaultMessage = 'Acima do Peso';
      } else {
        _defaultMessage = 'Obesidade';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.blue),
              textField(weightController, 'Peso (kg)', 'Insira seu Peso!'),
              textField(heightController, 'Altura (cm)', 'Insira sua Altura!'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                ),
              ),
              Text(
                _defaultMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textField(TextEditingController ctrl, String label, String errorMsg) {
  return Container(
    height: 80,
    child: TextFormField(
      controller: ctrl,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
      ),
      validator: (value){
        if (value.isEmpty) { return errorMsg; }
      },
    ),
  );
}