import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> savedMarkers = new Set<Marker>();
  Set<Marker> tempMarker = new Set<Marker>();
  int selectedMarkerId;
  // atualmente aponta para Niteroi
  double lat = -22.899153475969282;
  double long = -43.107521571547025;
  int markerIdCount = 0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget mapWidget() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      onCameraMove: (data) {
        //print(data);
      },
      onTap: (position) {
        final Marker marker = Marker(
          markerId: new MarkerId(markerIdCount.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: "Teste",
            snippet: "Niterói/RJ",
          ),
          onTap: () {
            selectedMarkerId = this.;
            print(selectedMarkerId);
          }
        );
        setState(() {
          tempMarker.clear();
          tempMarker.add(marker);
        });
        markerIdCount++;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, long),
        zoom: 11.0,
      ),
      markers: savedMarkers.union(tempMarker),
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

  void saveMarker() {
    savedMarkers.add(tempMarker.first);
    tempMarker.clear();
  }

  void removeSavedMarker() {
    if (tempMarker.length > 0 && int.parse(tempMarker.first.markerId.value) == selectedMarkerId) {
      tempMarker.clear();
    } else if (savedMarkers.length > 0) {
      print(selectedMarkerId);
      savedMarkers.removeWhere((marker) { print(int.parse(marker.markerId.value)); return int.parse(marker.markerId.value) == selectedMarkerId; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
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
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}