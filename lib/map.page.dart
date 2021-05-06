import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'model/bus.stop.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> tempMarker = new Set<Marker>();
  MarkerId selectedMarkerId;
  // atualmente aponta para Niteroi
  double lat = -22.899153475969282;
  double long = -43.107521571547025;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget mapWidget(Set<Marker> savedMarkers) {
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
          zoom: 11.0,
        ),
        markers: tempMarker //savedMarkers.union(tempMarker),
    );
  }

  Widget mapButton(Function function, Icon icon, Color color) {
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
    var savedMarkers = busStopModel.busStops;

    Future saveMarker(Set<Marker> savedMarkers) async {
      final data = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddMarkerScreen();
          }) as Map<String, String>;
      final tempMarkerId = MarkerId(UniqueKey().toString());
      setState(() {
        savedMarkers.add(
            Marker(
                markerId: MarkerId(UniqueKey().toString()),
                position: tempMarker.first.position,
                infoWindow: InfoWindow(
                  title: data['markerTitle'],
                  snippet: data['markerSnippet'],
                ),
                onTap: () {
                  selectedMarkerId = tempMarkerId;
                }
            )
        );
        tempMarker.clear();
      });
    }

    void removeSavedMarker(Set<Marker> savedMarkers) {
      if (savedMarkers.length > 0) {
        setState(() {
          savedMarkers.removeWhere((marker) { return marker.markerId == selectedMarkerId; });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Onify",
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 37, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: mapWidget(savedMarkers)
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      mapButton(saveMarker, Icon(Icons.add_location), Colors.green),
                      mapButton(removeSavedMarker, Icon(Icons.wrong_location), Colors.red),
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