

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/driver.dart';


class CreateDriver extends StatefulWidget {
  @override
  _CreateDriverState createState() => _CreateDriverState();
}

class _CreateDriverState extends State<CreateDriver> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String cpf;
  String driversLicenseType;
  String civilState;
  String sex;
  TextEditingController _dataNewDriver = TextEditingController();
  DateTime dtSelected = DateTime.now();

  //Validação e Salvamento na lista
  void _salvarForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(
        context,
        Driver(name: name, birthDate: dtSelected, cpf: cpf, driversLicenseType: driversLicenseType, civilState: civilState, sex: sex ),
      );
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime choosed = await showDatePicker(
        context: context,
        initialDate: dtSelected,
        firstDate: DateTime.utc(1900),
        lastDate: DateTime.now());
    if (choosed != null && choosed != dtSelected)
      setState(() {
        dtSelected = choosed;
        var date =
            "${choosed.toLocal().day}/${choosed.toLocal().month}/${choosed.toLocal().year}";
        _dataNewDriver.text = date;
      });
  }

//Buildar a Segunda tela referente ao cadastro do Novo Usuario
  @override
  Widget build(BuildContext context) {
    final Driver driver = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Adicionar Motorista",
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
                    initialValue: driver == null ?  null : driver.name,
                    onSaved: (val) => name = val,
                    decoration: InputDecoration(
                      labelText: 'Nome do Motorista',
                      icon: Icon(
                        Icons.person_add,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "Por favor o nome do motorista!";
                      return null;
                    }),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      onSaved: (val) {
                        dtSelected = dtSelected;
                      },
                      controller: _dataNewDriver,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "BirthDate",
                        icon: Icon(
                          Icons.celebration,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "Por favor insira sua data de Nascimento!";
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [

                    Expanded(child: TextFormField(
                      initialValue: driver == null ? null : driver.cpf,
                      onSaved: (val) => cpf = val,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                        icon: Icon(
                          Icons.assignment_turned_in,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value.isEmpty || value.length != 11) return " Seu CPF com 11 dígitos!";
                        return null;
                      }),),
                    Expanded(child: TextFormField(
                        initialValue: driver == null ? null : driver.driversLicenseType,
                        onSaved: (val) => driversLicenseType = val ,
                        decoration: InputDecoration(
                          labelText: 'Carteira de Motorista',
                          icon: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^[A-F]$')),
                        ],
                        validator: (value) {
                          if (value.length != 1) return "Sua carteira ex: 'A','D'...";
                          return null;
                        }),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(
                      initialValue: driver == null ? null : driver.civilState,
                      onSaved: (val) => civilState = val,
                      decoration: InputDecoration(
                        labelText: 'Estado civil',
                        icon: Icon(
                          Icons.supervisor_account_sharp,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) return "Seu estado civil!";
                        return null;
                      }),),
                    Expanded(child: TextFormField(
                        initialValue: driver == null ? null : driver.sex,
                        onSaved: (val) => civilState = val,
                        decoration: InputDecoration(
                          labelText: 'Gênero',
                          icon: Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^[MFO]$')),
                        ],
                        validator: (value) {
                          if (value.isEmpty) return "Seu genero. Ex: 'M' ou 'F'!";
                          return null;
                        }),),
                  ],
                ),
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