import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopModel extends ChangeNotifier{
  Set<Marker> _busStops = {};

  Set<Marker> get busStops {
    return _busStops;
  }

  void add(Marker marker) {
    _busStops.add(marker);
    notifyListeners();
  }

  void remove(MarkerId selectedId) {
    _busStops.removeWhere((marker) { return marker.markerId == selectedId; });
  }

  void removeAll() {
    _busStops.clear();
    notifyListeners();
  }
}
