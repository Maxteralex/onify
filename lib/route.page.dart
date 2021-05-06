import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/route.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    final routeModel = Provider.of<RouteModel>(context);
    var items = routeModel.routes;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Onify - Rotas",
            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 37, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
          ),
          centerTitle: true,
        ),
        body: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    child: ListTile(
                      title: Text('Nome: ${items[index].routeName} Num. Rota: ${items[index].routeNumber}'),
                    ),
                    key: UniqueKey(),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        setState(() {
                          routeModel.removeAt(index);
                        });
                      } else {
                        setState(() {
                          print('edit não foi feito ainda');
                        });
                      }
                    },
                  );
                },
              ),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return AddRouteScreen();
                    },
                  ));
                  setState(() {
                    items = routeModel.routes;
                  });
                },
                child: Icon(Icons.add),
              ),
            ]
        )
    );
  }
}

class AddRouteScreen extends StatelessWidget {

  Widget addScreenButton(Function function, String name, Color color) {
    return ElevatedButton(
        onPressed: function,
        child: Text(name),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeModel = Provider.of<RouteModel>(context);
    String routeName;
    int routeNumber;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Onify - Adicionar Rota",
            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 37, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'  ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da Rota',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                routeName = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Número da Rota',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                try {
                  routeNumber = int.parse(text);
                } catch(exception) {

                }
              },
            ),
            Row(
                children: [
                  addScreenButton(
                          () { Navigator.pop(context); }, 'Cancelar', Colors.red),
                  Container(
                    width: 67,
                  ),
                  addScreenButton(
                          () {
                        routeModel.add(routeName, routeNumber);
                        Navigator.pop(context);
                      }, 'Confirmar', Colors.blue
                  ),
                ]
            )
          ],
        )
    );
  }
}