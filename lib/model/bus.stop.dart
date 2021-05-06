import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopModel extends ChangeNotifier{
  Set<Marker> _busStops = {};
  int _idCounter = 0;

  Set<Marker> get busStops {
    return _busStops;
  }

  void add(String routeName, int routeNumber) {
    _busStops.add(new Marker(markerId: MarkerId(_idCounter.toString())));
    _idCounter++;
    notifyListeners();
  }

  void removeAll() {
    _busStops.clear();
    notifyListeners();
  }
}
