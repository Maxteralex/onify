

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_t1/model/bus.dart';
import 'package:flutter_t1/presentation/my_flutter_app_icons.dart';

class CreateBus extends StatefulWidget {
  @override
  _CreateBusState createState() => _CreateBusState();
}

class _CreateBusState extends State<CreateBus> {
  final _formKey = GlobalKey<FormState>();
  String plate;
  String brand;
  int busNumber;
  TextEditingController _dataNewBus = TextEditingController();

  //Validação e Salvamento na lista
  void _salvarForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(
        context,
        Bus(plate: plate, brand: brand, busNumber: busNumber),
      );
    }
  }

//Buildar a Segunda tela referente ao cadastro do Novo Usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Adicionar Onibus",
            style: TextStyle(color: Colors.white),
          ),
          leadingWidth: 90,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.red[700], fontSize: 16),
            ),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                TextFormField(
                    onSaved: (val) => plate = val,
                    decoration: InputDecoration(
                      labelText: 'Placa',
                      icon: Icon(
                        Icons.map,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Placa do veículo',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira sua placa!";
                      return null;
                    }),
                TextFormField(
                    onSaved: (val) => brand = val,
                    decoration: InputDecoration(
                      labelText: 'Marca',
                      icon: Icon(
                        Icons.branding_watermark,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Marca do veículo',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira a marca do veículo!";
                      return null;
                    }),
                TextFormField(
                    onSaved: (val) => brand = val,
                    decoration: InputDecoration(
                      labelText: 'Marca',
                      icon: Icon(
                        Icons.branding_watermark,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Marca do veículo',
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira a marca do veículo!";
                      return null;
                    }),
                Container(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _salvarForm,
                    label: Text('Confirmar'),
                    icon: Icon(Icons.check),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}