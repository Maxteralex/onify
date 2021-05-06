import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create.driver.page.dart';
import 'package:intl/intl.dart';

import 'model/driver.dart';

class DriverPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver',
      home: MyHomePage(title: 'Lista de Motoristas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Driver> drivers = [
    Driver(name: 'Joao Mateus Costa',birthDate: DateTime.utc(1975, 03, 14),cpf: '12356794576',driversLicenseType: 'D',civilState: 'married',sex: 'M' ),
    Driver(name: 'Marcela Dantas da Silva',birthDate: DateTime.utc(1978, 05, 24),cpf: '14567834521',driversLicenseType: 'E',civilState: 'single',sex: 'F' ),
    Driver(name: 'Julia Lima Carpilovsky',birthDate: DateTime.utc(1976, 02, 7),cpf: '14567834521',driversLicenseType: 'E',civilState: 'single',sex: 'F' ),
  ];

  // Função que espera o Motorista ser criado
  _waitingForNewDriver(BuildContext context, Widget page) async {
    Driver addDriver;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        )) as Driver;
    if (result != null) {
      addDriver = result;
      setState(() {
        drivers.add(addDriver);
      });
    }
  }
  // Função que espera a edição do  Motorista
  _waitingEditDriver(BuildContext context, Widget page, int index) async {
    Driver addDriver;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(arguments: drivers[index]),
          builder: (context) => page,
        )) as Driver;
    if (result != null) {
      addDriver = result;
      setState(() {
        drivers.removeAt(index);
        drivers.insert(index, addDriver);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        textTheme: TextTheme(headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontStyle: FontStyle.normal, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),),
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: drivers.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(

                      'Nome:\t${drivers[index].name}',
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 23, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),
                    ),
                    subtitle:
                    Text('Aniversário:\t' + DateFormat('dd/MM/yyyy').format(drivers[index].birthDate),
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),
                    ),
                    isThreeLine: true,
                    dense: false,
                  ),
                  background: scrollRightBackground(),
                  secondaryBackground: scrollLeftBackground(),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        drivers.removeAt(index);
                      });
                    } else {
                      setState(() {
                        _waitingEditDriver(context, CreateDriver(),index);
                        print('edit não foi feito ainda');
                      });
                    }
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () => _waitingForNewDriver(context, CreateDriver()),
        child: Icon(Icons.add),
      ),
    );
  }
}

// Arrastar para a direita para Editar o Usuario (Não IMPLEMENTADO - Apenas visual)
Widget scrollRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Editar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

// Arrastar para a esquerda para Deletar o Usuario
Widget scrollLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Deletar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
