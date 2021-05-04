import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = -22.899153475969282;
  double long = -43.107521571547025;
  int id = 0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          onCameraMove: (data) {
            print(data);
          },
          onTap: (position) {
            final Marker marker = Marker(
              markerId: new MarkerId(id.toString()),
              position: position,
              infoWindow: InfoWindow(
                title: "Teste",
                snippet: "Niterói/RJ",
              ),
            );
            setState(() {
              markers.add(marker);
            });
            id++;
            print(position);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, long),
            zoom: 11.0,
          ),
          markers: markers,
        ),
    )
    );
  }
}