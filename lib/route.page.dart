import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/route.dart';


class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  void showInfo(route) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
      return ShowRouteInfoScreen(
        route: route
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeModel = Provider.of<RouteModel>(context);
    var items = routeModel.routes;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          textTheme: TextTheme(headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontStyle: FontStyle.normal, fontSize: 37, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),),
          title: Text('Lista de Rotas'),
        ),
        body: Container(

            child: ListView.builder(

              itemCount: items.length,

              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return Dismissible(
                  child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                      'Nome da Rota: ${items[index].routeName}',
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 23, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),
                    ),
                    subtitle: Text(
                      'Número da Rota: ${items[index].routeNumber}',
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'PatrickHand'),
                    ),
                    onTap: () {
                      showInfo(items[index]);
                    },

                  ),
                  key: UniqueKey(),
                  background: arrastarParaDireitaBackground(),
                  secondaryBackground: arrastarParaEsquerdaBackground(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        routeModel.removeAt(index);
                      });
                      /// delete
                      return true;
                    }
                    // edit
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditRouteScreen(
                                route: items[index]
                            )
                        )
                    );
                    return false;
                  },
                );
              },
            ),

        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return AddEditRouteScreen();
            },
          ));
          setState(() {
            items = routeModel.routes;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

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

class ShowRouteInfoScreen extends StatelessWidget {
  final route;
  ShowRouteInfoScreen({this.route});

  String showBusStops(markers) {
    /* Concatena o nome das paradas
       de ônibus linha a linha */
    if (markers.length > 0) {
      String result = '';
      for (final marker in route.getBusStops()) {
        result += marker.infoWindow.title + '\n';
      }
      return result;
    }
    return 'Não há pontos criados.';
  }

  @override
  Widget build(BuildContext context) {

    Widget dialogButton(Function function, String name, Color color) {
      return ElevatedButton(
          onPressed: function,
          child: Text(name),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          )
      );
    }

    return SimpleDialog(
      title: const Text('Informações da Rota'),
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            children: [
              Text('Nome da Rota: ' + route.getRouteName()),
              Container(
                height: 20,
              ),
              Text('Número da Rota: ' + route.getRouteNumber().toString()),
              Container(
                height: 20,
              ),
              Text('Pontos de Ônibus da Rota:'),
              Text(showBusStops(route.getBusStops())),
              Container(
                height: 20,
              ),
              Row(
                children: [
                  dialogButton(
                    () {
                      Navigator.pop(context);
                    }, 'Voltar', Colors.blue
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddEditRouteScreen extends StatefulWidget {
  final route;
  AddEditRouteScreen({this.route});

  @override
  _AddEditRouteState createState() => _AddEditRouteState(route: route);
}

class _AddEditRouteState extends State<AddEditRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  final route;
  String routeName;
  int routeNumber;
  final routeNumberController = TextEditingController();

  _AddEditRouteState({this.route});

  @override
  Widget build(BuildContext context) {
    final routeModel = Provider.of<RouteModel>(context);

    void _salvarForm() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        if (route == null) {
          routeModel.add(routeName, routeNumber);
        } else {
          route.updateRouteAttrs(routeName, routeNumber);
        }
        Navigator.pop(context);
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            route == null ? "Adicionar Rota" : "Editar Rota",
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
                    initialValue: route == null ?  null : route.getRouteName(),
                    onSaved: (val) => routeName = val,
                    decoration: InputDecoration(
                      labelText: 'Nome da Rota',
                      icon: Icon(
                        Icons.alt_route,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Nome da Rota',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira o nome da rota!";
                      return null;
                    }),
                TextFormField(
                    initialValue: route == null ? null : route.routeNumber.toString(),
                    onSaved: (val) => routeNumber = int.parse(val) ,
                    decoration: InputDecoration(
                      labelText: 'Número da Rota',
                      icon: Icon(
                        Icons.format_list_numbered,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Número da Rota',
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira o número da rota!";
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
        )
      )
    );
  }
}