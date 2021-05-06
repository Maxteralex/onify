import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create.bus.page.dart';
import 'model/bus.dart';
import 'package:provider/provider.dart';

class BusPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho Flutter',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(title: 'Lista de Ônibus'),
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
  List<Bus> buses = [
    Bus(brand: 'Volkswagen', busNumber: 1, plate: 'RIO2A18'),
    Bus(brand: 'FIAT', busNumber: 2, plate: 'KXA2A33'),
    Bus(brand: 'Volkswagen', busNumber: 2, plate: 'PPO1Y01'),
    Bus(brand: 'Volkswagen', busNumber: 2, plate: 'REO2Y73'),
    Bus(brand: 'HYUNDAI', busNumber: 3, plate: 'VBO0Y76'),
    Bus(brand: 'HYUNDAI', busNumber: 1, plate: 'IOO8Y21'),
  ];

  // Função que espera o Usuario ser criado
  _esperaDoNovoOnibus(BuildContext context, Widget page) async {
    Bus addBus;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        )) as Bus;
    if (result != null) {
      addBus = result;
      setState(() {
        buses.add(addBus);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: buses.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: ListTile(
                    title: Text(
                      'Placa:\t${buses[index].plate}',
                    ),
                    subtitle:
                        Text('Rota pertencente:\t${buses[index].busNumber}'),
                  ),
                  background: arrastarParaDireitaBackground(),
                  secondaryBackground: arrastarParaEsquerdaBackground(),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        buses.removeAt(index);
                      });
                    } else {
                      setState(() {
                        print('edit não foi feito ainda');
                      });
                    }
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _esperaDoNovoOnibus(context, CreateBus()),
        child: Icon(Icons.add),
      ),
    );
  }
}

// Arrastar para a direita para Editar o Usuario (Não IMPLEMENTADO - Apenas visual)
Widget arrastarParaDireitaBackground() {
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
Widget arrastarParaEsquerdaBackground() {
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
