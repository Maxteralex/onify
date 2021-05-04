import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> saved_markers = new Set<Marker>();
  Set<Marker> temp_marker = new Set<Marker>();
  // atualmente aponta para Niteroi
  double lat = -22.899153475969282;
  double long = -43.107521571547025;
  int marker_id = 0;

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
          markerId: new MarkerId(marker_id.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: "Teste",
            snippet: "Niterói/RJ",
          ),
        );
        setState(() {
          temp_marker.clear();
          temp_marker.add(marker);
        });
        marker_id++;
        print(position);
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, long),
        zoom: 11.0,
      ),
      markers: saved_markers.union(temp_marker),
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
    saved_markers.add(temp_marker.first);
    temp_marker.clear();
  }

  void removeSavedMarker() {

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