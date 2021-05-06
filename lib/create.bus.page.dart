

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/bus.dart';


class CounterFormField extends FormField<int> {

  CounterFormField({
    FormFieldSetter<int> onSaved,
    FormFieldValidator<int> validator,
    int initialValue = 0,
    bool autovalidate = false
  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      enabled: autovalidate,
      builder: (FormFieldState<int> state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                state.didChange(state.value - 1);
              },
            ),
            Text(
                state.value.toString()
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                state.didChange(state.value + 1);
              },
            ),
          ],
        );
      }
  );
}

class CreateBus extends StatefulWidget {
  @override
  _CreateBusState createState() => _CreateBusState();
}

class _CreateBusState extends State<CreateBus> {
  final _formKey = GlobalKey<FormState>();
  String plate;
  String brand;
  int busNumber;
  final busNumerController = TextEditingController();
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
        resizeToAvoidBottomInset: false,
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
        body: SingleChildScrollView(child: SafeArea(
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
                CounterFormField(
                  autovalidate: false,
                  validator: (value) {
                    if (value < 0) {
                      return 'Negative values not supported';
                    } return null;
                  },
                  onSaved: (value) => this.busNumber = value,
                ),
                TextFormField(
                    onSaved: (val) => brand = val ,
                    decoration: InputDecoration(
                      labelText: 'Numero da Rota',
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
        )));
  }
}