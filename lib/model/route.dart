import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bus.dart';

class RouteModel extends ChangeNotifier{
  List<Route> _routes = [
    Route(routeName: 'Lagoa-Barra', routeNumber: 1),
    Route(routeName: 'Rio-Niteroi', routeNumber: 2),
    Route(routeName: 'Copacabana-Ipanema', routeNumber: 3),
    Route(routeName: 'Centro', routeNumber: 4),
  ];

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
  Set<Marker> busStops = {};
  List<Bus> buses = [];

  Route({this.routeName, this.routeNumber});

  String getRouteName() {
    return routeName;
  }

  int getRouteNumber() {
    return routeNumber;
  }

  void setRouteName(String routeName) {
    this.routeName = routeName;
  }

  void setRouteNumber(int routeNumber) {
    this.routeNumber = routeNumber;
  }

  Set<Marker> getBusStops() {
    print(busStops);
    return busStops;
  }

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
