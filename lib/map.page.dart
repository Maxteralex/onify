import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'model/bus.stop.dart';
import 'package:geolocator/geolocator.dart';



class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> tempMarker = new Set<Marker>();
  Set<Marker> savedMarkers = new Set<Marker>();
  MarkerId selectedMarkerId;
  // atualmente aponta para Niteroi
  double lat = -22.899153475969282;
  double long = -43.107521571547025;


  void setSavedMarkers(Set<Marker> markers) {
    /* Resgata os markers guardados e os
       coloca no set de markers salvos */
    savedMarkers = markers;
  }

  void _getCurrentLocation() async{

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    position != null ? lat = position.latitude : lat = -22.899153475969282;
    position != null ? long = position.longitude : long = -43.107521571547025;
    mapWidget();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget mapWidget() {
    /* Widget do Google Maps */
    return GoogleMap(
        onMapCreated: _onMapCreated,
        onCameraMove: (data) {
          //print(data);
        },
        onLongPress: (position) {
          final Marker marker = Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: position,
          );
          setState(() {
            tempMarker.clear();
            tempMarker.add(marker);
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          zoom: lat != -22.899153475969282 ? 14.0 : 11.0 ,
        ),
      markers: savedMarkers.union(tempMarker),
    );
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    /* Generalização de botões para o mapa */
    return ElevatedButton(
        onPressed: function,
        child: icon,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(new CircleBorder()),
          elevation: MaterialStateProperty.all(2.0),
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(const EdgeInsets.all(7.0)),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final busStopModel = Provider.of<BusStopModel>(context);
    setSavedMarkers(busStopModel.busStops);

    Future saveMarker() async {
      /* Abre uma caixa de diálogo para obter o nome
         que será dado ao marker e, por fim, salva no
         Provider de BusStopModel, atualizando o estado
         da página. */
      final addData = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddMarkerScreen();
          }) as Map<String, String>;
      final tempMarkerId = MarkerId(UniqueKey().toString());
      setState(() {
        busStopModel.add(
            Marker(
                markerId: tempMarkerId,
                position: tempMarker.first.position,
                infoWindow: InfoWindow(
                  title: addData['markerTitle'],
                  snippet: addData['markerSnippet'],
                ),
                onTap: () {
                  selectedMarkerId = tempMarkerId;
                }
            )
        );
        tempMarker.clear();
      });
    }

    void removeSavedMarker() {
      /* Remove o marker selecionado se este estiver
         salvo, atualizando o estado da página. */
      if (savedMarkers.length > 0) {
        setState(() {
          busStopModel.remove(selectedMarkerId);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Onify",
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: mapWidget()
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      mapButton(saveMarker, Icon(Icons.add_location), Colors.green),
                      mapButton(removeSavedMarker, Icon(Icons.wrong_location), Colors.red),
                      mapButton(_getCurrentLocation, Icon(Icons.gps_fixed), Colors.black)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class AddMarkerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String markerTitle;
    String markerSnippet;

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
      title: const Text('Adicionar Ponto (Marker)'),
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome do Ponto (Marker)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  markerTitle = text;
                },
              ),
              Container(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  markerSnippet = text;
                },
              ),
              Container(
                height: 20,
              ),
              Row(
                children: [
                  dialogButton(() { Navigator.pop(context); }, 'Cancelar', Colors.red),
                  Container(
                    width: 67,
                  ),
                  dialogButton(
                          () {
                        if (markerTitle != '') {
                          final data = {
                            'markerTitle': markerTitle,
                            'markerSnippet': markerSnippet
                          };
                          Navigator.pop(context, data);
                        } else {

                        }
                      }, 'Confirmar', Colors.blue
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