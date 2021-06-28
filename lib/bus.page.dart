

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'create.bus.page.dart';
import 'generated/l10n.dart';
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
      title: 'Bus' ,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ] ,
      home: MyHomePage(title: "Ônibus"),
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
  _esperaDoEditOnibus(BuildContext context, Widget page, int index) async {
    Bus addBus;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(arguments: buses[index]),
          builder: (context) => page,
        )) as Bus;
    if (result != null) {
      addBus = result;
      setState(() {
        buses.removeAt(index);
        buses.insert(index, addBus);
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
        title: Text(S.of(context).busTitle),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: buses.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(

                        '${S.of(context).plate}:\t${buses[index].plate}',
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 23, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),
                    ),
                    subtitle:
                        Text('${S.of(context).routeBelongs}:\t${buses[index].busNumber}',
                            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),),
                  ),
                  background: arrastarParaDireitaBackground(context),
                  secondaryBackground: arrastarParaEsquerdaBackground(context),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        buses.removeAt(index);
                      });
                    } else {
                      setState(() {
                        _esperaDoEditOnibus(context, CreateBus(),index);
                      });
                    }
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () => _esperaDoNovoOnibus(context, CreateBus()),
        child: Icon(Icons.add),
      ),
    );
  }
}

// Arrastar para a direita para Editar o Usuario
Widget arrastarParaDireitaBackground(BuildContext context) {
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
            S.of(context).edit,
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
Widget arrastarParaEsquerdaBackground(BuildContext context) {
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
            S.of(context).remove,
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
