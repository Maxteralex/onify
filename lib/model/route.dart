import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bus.dart';

class RouteModel extends ChangeNotifier{
  List<Route> _routes = [];

  List<Route> get routes {
    return _routes;
  }

  void add(String routeName, int routeNumber) {
    _routes.add(new Route(routeName: routeName, routeNumber: routeNumber));
    notifyListeners();
  }

  void removeAt(int index) {
    _routes.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _routes.clear();
    notifyListeners();
  }
}

class Route {
  String routeName;
  int routeNumber;
  Set<Marker> busStops;
  List<Bus> buses;

  Route({this.routeName, this.routeNumber});

  void addBusStop(Marker marker) {
    busStops.add(marker);
  }

  void addAllBusStops(List<Marker> markers) {
    busStops.addAll(markers);
  }

  void removeBusStop(Marker marker) {
    busStops.remove(marker);
  }
}
